# ChannelFlow-logica

Specificatie van de ChannelFlow-sessielogica zoals geïmplementeerd in de LeadTrackr GTM Community Template. Dit document is de referentie voor elke andere implementatie — WordPress-plugin, Shopify-app, LeadBot — zodat die exact hetzelfde gedrag vertonen.

Status: vastgesteld · Bron van waarheid: `template.tpl` in `leadtrackr/gtm-leadtrackr-tag`

---

## 1. Waarom

De oude logica registreerde geen sessies maar kanaalwisselingen. Een entry werd alleen weggeschreven als het kanaal verschilde van de vorige:

```js
if (channelFlow.length > 0 && !hasNewUtmParams) {
  currentChannelData = lastEntry.channel;   // kanaal wordt overgenomen
}
const isSameEntry = lastEntry &&
  JSON.stringify(lastEntry.channel) === JSON.stringify(newEntry.channel);
if (!isSameEntry) channelFlow.push(newEntry);
```

Daardoor gebeurden er twee dingen die niet kloppen:

- **Herhaalbezoeken verdwenen.** Dag 1 direct, dag 5 direct en dag 20 direct werden samen één entry met de tijdstempel van dag 1. In de journey leek het alsof iemand twintig dagen in dezelfde sessie zat.
- **Terugkerend direct verkeer werd niet vastgelegd.** Kwam iemand op dag 1 via google/cpc en op dag 5 rechtstreeks terug, dan nam die pageview het vorige kanaal over — er kwam geen tweede entry, want er waren geen nieuwe UTM's.

De kern van de fix: **een ChannelFlow-entry is het begin van een sessie**, niet een kanaalwisseling.

---

## 2. Sessiedefinitie

Gebaseerd op hoe GA4 sessies telt, zodat ChannelFlow en GA4-data met elkaar te vergelijken zijn.

Er start een nieuwe sessie wanneer één van deze drie waar is:

| # | Voorwaarde | Toelichting |
|---|---|---|
| 1 | Er is nog geen ChannelFlow | Eerste bezoek ooit, of cookie verwijderd |
| 2 | De sessiecookie is verlopen | Standaard 30 minuten zonder pageview |
| 3 | Nieuw campagnesignaal met afwijkend kanaal | UTM's óf click-ID in de URL die een ander kanaal opleveren dan de laatste entry |

Voorwaarde 3 heeft die tweede eis expliciet nodig: zonder de vergelijking met de laatste entry zou het verversen van een landingspagina mét UTM's telkens een dubbele entry opleveren.

### Pseudocode

```
per pageview:

  now      = huidige tijd in ms
  flow     = lees lt_channelflow          → array, [] bij leeg of ongeldig
  actief   = bestaat lt_session?
  kanaal   = bepaalKanaal()
  signaal  = utm-parameters aanwezig OF click-ID aanwezig

  nieuweSessie =
        flow is leeg
     OF niet actief
     OF (signaal EN kanaal ≠ kanaal van laatste entry)

  als nieuweSessie:
     flow.push({ t: now, ch: kanaal, lp: pad() })
     flow = pasLimietenToe(flow)

  schrijf lt_channelflow (395 dagen)
  schrijf lt_session     (timeout)
```

`lt_channelflow` wordt bij élke pageview herschreven, ook als er geen entry bijkomt. Dat verlengt de 395-dagen-window zolang iemand actief is. `lt_session` wordt óók elke pageview herschreven; dat maakt het een schuivend venster van 30 minuten inactiviteit.

### Bewust gedrag

Klikt iemand na meer dan 30 minuten stilstand op een interne link, dan is de referrer het eigen domein en wordt die nieuwe sessie `direct / none`. Dat is hetzelfde als wat GA4 doet, maar het betekent dat een lange leespauze een directe sessie oplevert.

---

## 3. Kanaalbepaling

Eerste regel die matcht wint.

| # | Voorwaarde | Resultaat |
|---|---|---|
| 1 | Eén of meer UTM-parameters in de URL | De UTM-waarden zelf |
| 2 | `gclid`, `gbraid` of `wbraid` in de URL | `google / cpc` |
| 3 | `msclkid` in de URL | `bing / cpc` |
| 4 | Referrer is extern én een zoekmachine | `<label> / organic`, bijv. `google / organic` |
| 5 | Referrer is extern | `<volledige host> / referral` |
| 6 | Rest | `direct / none` |

### Click-ID's: alleen uit de URL

De click-ID telt uitsluitend als hij in de query van díé pageview staat. **Nooit uit de `_gcl_aw`-cookie lezen** — die blijft 90 dagen staan, waardoor élk vervolgbezoek opnieuw als `google / cpc` zou worden geregistreerd en de journey volloopt met advertentie-touchpoints die nooit hebben plaatsgevonden.

`gbraid` en `wbraid` horen erbij omdat het gewoon Google Ads-klikken zijn (iOS- en app-campagnes) met een andere parameternaam.

### Click-ID's: niet bij een interne referrer

Regel 2 en 3 gelden alleen wanneer de referrer **niet** je eigen domein is.

Consent Mode's `url_passthrough` plakt de `gclid` namelijk aan élke interne link zodra `ad_storage` geweigerd is. Zonder deze uitzondering staat die parameter bij iedere volgende pageview nog in de URL, en zou elke verlopen sessie opnieuw een `google / cpc`-entry opleveren — iemand die met geweigerde toestemming een uur doorklikt bouwt zo een journey vol advertentieklikken die nooit hebben plaatsgevonden.

De controle sluit precies aan op het mechanisme: passthrough werkt via interne links, dus die pageviews hebben je eigen domein als referrer. Een echte advertentieklik komt van buiten.

```
isInterneReferrer = referrer bestaat EN
                    registrableDomain(referrer) == registrableDomain(huidigeHost)

clickIdKanaal     = isInterneReferrer ? geen : clickIdUitQuery()
```

**Een lege referrer telt niet als intern.** Een echte advertentieklik kan zonder referrer binnenkomen, bijvoorbeeld via een redirect of bij een strak `referrer-policy` aan de kant van de adverteerder.

Naast de kanaalbepaling geldt dit ook voor het campagnesignaal uit §2: een meegesleepte click-ID mag ook geen nieuwe sessie forceren.

#### Overwogen alternatieven

**Een vingerafdruk van de click-ID opslaan** en die vergelijken, zodat dezelfde klik maar één keer telt. Werkt onafhankelijk van de referrer en is daarmee waterdichter, maar kost een extra veld in elke cpc-entry plus terugzoeklogica — te veel apparaat voor wat een fallback is.

**De fallback uitzetten bij een sessietimeout.** Verworpen: een advertentieklik ná 30 minuten stilstand *is* een timeout-sessie, en dat is verreweg de normaalste manier waarop een klik binnenkomt. De kanaalbepaling zou dan terugvallen op de referrer, en die is bij een Google-advertentie `www.google.com`. Elke advertentieklik kwam zo als `google / organic` in de journey — betaald verkeer dat je organische cijfers vervuilt terwijl je je klikken kwijt bent.

#### Bekende beperking

Op een site waar ook interne navigatie geen referrer meestuurt (strak `referrer-policy`) kan een meegesleepte `gclid` na een sessietimeout alsnog een extra cpc-entry opleveren. Geaccepteerd; de vingerafdruk hierboven is de oplossing mocht dit in de praktijk opspelen.

`fbclid` staat er bewust **niet** bij. Facebook plakt die op elke uitgaande link, ook op organische posts en Messenger-berichten. Zou je die op `facebook / cpc` zetten, dan telde organisch social verkeer mee als betaald. Facebook-verkeer komt via regel 5 binnen als `facebook.com / referral`.

`dclid` (Display & Video 360) blijft er ook uit — dat is display, geen cpc.

### Zoekmachineherkenning

De oude implementatie vergeleek de volledige host tegen `['google.com', 'bing.com', ...]` met `indexOf`. Een bezoeker via **google.nl** gaf `referrerHost = 'www.google.nl'`, en `'www.google.nl'.indexOf('google.com')` is `-1`. Nederlands organisch verkeer werd daardoor als `www.google.nl / referral` opgeslagen in plaats van `google / organic`.

De nieuwe aanpak vergelijkt het domeinlabel, waardoor alle landendomeinen in één keer goed gaan:

```
SECOND_LEVEL = ['co','com','org','net','gov','edu','ac','mil']

registrableDomain(host):
    parts = host.split('.')
    als parts.length <= 2         → host
    als parts[len-2] in SECOND_LEVEL → laatste 3 delen
    anders                        → laatste 2 delen

domainLabel(host) = eerste deel van registrableDomain(host)
```

| Host | registrableDomain | label |
|---|---|---|
| `www.google.nl` | `google.nl` | `google` |
| `www.google.co.uk` | `google.co.uk` | `google` |
| `shop.klant.nl` | `klant.nl` | `klant` |

Zoekmachinelabels: `google`, `bing`, `yahoo`, `duckduckgo`, `baidu`, `ecosia`, `yandex`, `startpage`, `qwant`, `brave`, `naver`.

### Intern verkeer

Een referrer is intern wanneer `registrableDomain(referrer) === registrableDomain(huidigeHost)`. Dat vergelijkt op domeinniveau en niet op volledige host, zodat een sprong van `www.klant.nl` naar `shop.klant.nl` niet als referral wordt geteld. Intern verkeer valt door naar `direct / none`.

Bij een referral is de source de **volledige host** (`www.example.com`), bij organic het **label** (`google`). Dat is bewust, en gelijk aan hoe GA4 het doet.

---

## 4. Cookies

### `lt_channelflow`

| | |
|---|---|
| Levensduur | 395 dagen (`max-age`) |
| Domein | `auto` (deelbaar over subdomeinen) |
| Pad | `/` |
| Schrijfmoment | Elke pageview |

### `lt_session`

| | |
|---|---|
| Waarde | `"1"` |
| Levensduur | De ingestelde timeout, standaard 30 minuten |
| Domein | `auto` |
| Pad | `/` |
| Schrijfmoment | Elke pageview |

De cookie bevat geen logica; het bestaan ervan ís het signaal. Verlopen wordt aan de browser overgelaten, dus er hoeft nergens met tijdstempels vergeleken te worden.

**Consent speelt hierin geen rol.** De CMP is verantwoordelijk voor het blokkeren van deze cookies. De tag plaatst ze onvoorwaardelijk en registreert alleen wát de consent-status op dat moment was (zie §7).

---

## 5. Dataformaat

### Compact formaat in de cookie

```json
[
  {"t":1753080000000,"ch":{"s":"google","m":"cpc","cm":"zomeractie"},"lp":"/tracking"},
  {"t":1753512000000,"ch":{"s":"direct","m":"none"},"lp":"/prijzen"}
]
```

| Sleutel | Betekenis |
|---|---|
| `t` | Tijdstempel sessiestart, epoch ms |
| `ch.s` | source |
| `ch.m` | medium |
| `ch.cm` | campaign |
| `ch.ct` | content |
| `ch.tm` | term |
| `lp` | Landingspagina, alleen het pad |

**Lege velden worden weggelaten**, niet als `""` opgeslagen. Dat scheelt ongeveer 45 bytes op elke direct- en organic-entry, en dat is precies het verschil tussen wel en niet binnen de cookielimiet blijven.

### Achterwaartse compatibiliteit

Er staan cookies in het veld met het oude, uitgeschreven formaat:

```json
[{"timestamp":1753080000000,"channel":{"source":"google","medium":"cpc","campaign":"","content":"","term":""}}]
```

Elke implementatie moet bij het **lezen** beide vormen herkennen — te onderscheiden aan de aanwezigheid van `t` versus `timestamp` — en bij het **schrijven** altijd compact terugschrijven. Bestaande journeys blijven zo intact en migreren vanzelf bij het eerstvolgende bezoek. Oude entries hebben geen `lp`; dat veld is optioneel.

---

## 6. Limieten

De browserlimiet is 4 KB per cookie, en bij overschrijding wordt de cookie **stil geweigerd** — dan is de hele journey in één klap weg. Daarom twee begrenzingen tegelijk:

| Limiet | Waarde |
|---|---|
| Maximum aantal entries | 25 |
| Maximum cookielengte | 3500 tekens |

Bij overschrijding van één van beide wordt telkens de **tweede** entry verwijderd, net zolang tot het past. De eerste entry blijft dus altijd staan: dat is de first touch, en zonder die entry is first-touch-attributie onmogelijk.

```
pasLimietenToe(flow):
    zolang flow.length > 25 EN flow.length > 1:
        verwijder flow[1]
    zolang urlEncode(stringify(flow)).length > 3500 EN flow.length > 1:
        verwijder flow[1]
    return flow
```

**Meet de URL-gecodeerde lengte, niet de ruwe JSON.** De cookie wordt gecodeerd opgeslagen, en juist de leestekens in JSON — `{`, `}`, `"`, `,`, `:` — worden daarbij elk drie tekens lang. Dat maakt de opgeslagen waarde ruwweg 1,7 keer zo groot als de JSON zelf. Meten op de ruwe lengte zou dus een cookie van bijna 6 KB toestaan, ruim over de limiet waar hij stil geweigerd wordt.

In de praktijk komt het hier op neer:

| Verkeerstype | Entries binnen de limiet | Opgeslagen lengte |
|---|---|---|
| Direct en organic | 25 (de telling bindt) | ~3100 tekens |
| Volledig getagde campagnes met lange namen | ~10 (de lengte bindt) | ~3200 tekens |

---

## 7. Landingspagina, conversiepagina en consent

### Landingspagina (per touchpoint)

Alleen het **pad**, zonder querystring, afgekapt op 100 tekens. Opgeslagen in de cookie onder `lp` op het moment dat de sessie begint.

Geen querystring, om twee redenen: UTM's en click-ID's worden al apart vastgelegd, en URL-parameters bevatten soms persoonsgegevens.

### Conversiepagina

**Host plus pad**, zonder querystring. Wordt live uitgelezen op het conversiemoment en kost dus geen cookiebytes.

```
www.klant.nl/offerte-aanvraag
```

### Consent

Puur observationeel: vastleggen wat de status was, niets blokkeren. Alleen op het conversiemoment, niet per touchpoint.

Vier signalen: `ad_storage`, `analytics_storage`, `ad_user_data`, `ad_personalization`.

**In GTM** via de template-API:

```js
const isConsentGranted = require('isConsentGranted');
isConsentGranted('ad_storage');   // boolean
```

Vereist de `access_consent`-permissie voor die vier types. Let op: de API geeft een boolean, dus er is geen onderscheid tussen "geweigerd" en "niet geconfigureerd" — beide gevallen zonder consent mode leveren `granted` op.

**Buiten GTM** bestaat er geen gedocumenteerde API. Gebruik een keten van bronnen en laat falen altijd `unknown` opleveren, nooit `granted`:

1. Een waarde die de site zelf expliciet meegeeft aan de tracker
2. De footprint van de CMP zelf — Cookiebot (`CookieConsent`), Complianz, CookieYes, Borlabs, OneTrust (`OptanonConsent`). Dit is de aanpak die Simo Ahava aanraadt, mits de CMP-status synchroon loopt met consent mode.
3. `window.google_tag_data.ics.getConsentState(type)` als best-effort — `1` = granted, `2` = denied, alles anders onbekend. **Ongedocumenteerd en kan zonder aankondiging wijzigen**, dus nooit als enige bron gebruiken.
4. Anders `unknown`

---

## 8. Payload naar de API

Endpoint blijft `POST https://app.leadtrackr.io/api/leads/createLead`. Geen API-token nodig; de route valideert alleen het project.

```json
{
  "projectId": "…",
  "formData": { "…": "…" },
  "userData": { "…": "…" },
  "channelFlow": [
    { "t": 1753080000000, "ch": { "s": "google", "m": "cpc" }, "lp": "/tracking" }
  ],
  "attributionData": {
    "gclid": "…", "wbraid": "…", "fbc": "…", "fbp": "…", "cid": "…",
    "conversionPage": "www.klant.nl/offerte-aanvraag",
    "consent": {
      "ad_storage": "granted",
      "analytics_storage": "granted",
      "ad_user_data": "granted",
      "ad_personalization": "denied"
    }
  }
}
```

`conversionPage` en `consent` staan **binnen** `attributionData` en niet op het hoogste niveau. Reden: `createLead` destructureert alleen bekende velden uit de body (`route.tsx:23-36`), dus nieuwe top-level velden worden stil weggegooid. `attributionData` is een doorgeefluik naar een json-kolom en wordt bij lead-updates samengevoegd in plaats van overschreven (`process-lead.ts:64`).

### Twee sleutels, één betekenis

De backend accepteert beide vormen — `createLead/route.tsx:66` doet `channelFlow || lt_channelflow`:

| Bron | Sleutel | Vorm |
|---|---|---|
| GTM-tag | `channelFlow` | Geparste array |
| WordPress-plugin | `lt_channelflow` | Ruwe cookiestring, server-side uit `$_COOKIE` |

Beide belanden ongewijzigd in de `channel_flow`-kolom (`schema.ts:290`, ongetypeerde json). Dat mag zo blijven; er is geen reden de frontends gelijk te trekken.

### Benodigde backend-aanpassing

Eén functie: `normalizeChannelFlow()` in `src/lib/channel-flow.ts`. Die pakt nu al array, JSON-string én URL-encoded JSON-string af, maar verwacht daarna de lange sleutels. Er moet herkenning van het compacte formaat bij, en een vertaling naar het bestaande `ChannelFlowStep`-type:

```
t   → timestamp        lp    → landingPage
ch.s  → channel.source     ch.ct → channel.content
ch.m  → channel.medium     ch.tm → channel.term
ch.cm → channel.campaign
```

Dit is de enige plek die het formaat hoeft te kennen; alles wat de journey rendert loopt hierdoorheen.

---

## 9. Instellingen

| Instelling | Standaard | Toelichting |
|---|---|---|
| Sessietimeout | 30 minuten | Per klant instelbaar in de tag-UI |
| UTM-parameternamen | `utm_source` etc. | Al aanwezig als "Custom UTM Parameters" |

---

## 10. Testscenario's

Elke implementatie moet deze gevallen halen.

| Scenario | Verwacht resultaat |
|---|---|
| Dag 1 direct, dag 5 direct, dag 20 direct | 3 entries |
| Dag 1 `google/cpc`, dag 5 direct | 2 entries, tweede is `direct / none` |
| Landingspagina verversen met dezelfde UTM's | 1 entry |
| Andere campagne binnen dezelfde sessie | 2 entries |
| `gclid` in URL, geen UTM's | `google / cpc` |
| `gclid` alleen in `_gcl_aw`-cookie, niet in URL | Géén cpc-entry |
| `gclid` meegesleept over verlopen sessies, interne referrer | Eén cpc-entry, daarna `direct / none` |
| `gclid` meegesleept binnen de sessie | Geen nieuwe entry |
| Echte klik na een sessietimeout, referrer `google.com` | `google / cpc`, niet organic |
| Tweede echte advertentieklik dagen later | Wel een nieuwe cpc-entry |
| Meegesleepte `gclid` zonder referrer | Bekende beperking: levert wél een extra cpc-entry op |
| Referrer `www.google.nl` | `google / organic` |
| Referrer `www.google.co.uk` | `google / organic` |
| Referrer `facebook.com` | `facebook.com / referral` |
| `www.klant.nl` → `shop.klant.nl` na timeout | `direct / none`, geen referral |
| Interne klik binnen de sessie | Geen nieuwe entry |
| Interne klik na 30 minuten stilstand | Nieuwe entry, `direct / none` |
| 26e sessie | First touch staat er nog, tweede entry verwijderd |
| Lange campagnenamen, veel sessies | Cookie blijft onder 3,5 KB |
| Cookie in oud formaat ingelezen | Omgezet naar compact, niets verloren |
| Ongeldige JSON in de cookie | Behandeld als leeg, nieuwe flow opgebouwd |

---

## 11. Aandachtspunten voor de WordPress-plugin

De plugin **leest** `lt_channelflow` vandaag alleen server-side uit `$_COOKIE` (`leadtrackr.php:539`) en stuurt de ruwe string door. Hij schrijft de cookie niet. Op een site zonder GTM is er dus helemaal geen ChannelFlow.

Wat er bij de uitbreiding moet gebeuren:

1. **Schrijven vanuit de front-end, in JavaScript.** Niet in PHP. Paginacaching (WP Rocket, Cloudflare, Varnish) zorgt ervoor dat PHP niet per pageview draait, waardoor server-side gezette cookies en referrerdetectie onbetrouwbaar worden.
2. **Script enqueuen op de voorkant.** `leadtrackr_enqueue_scripts()` wordt nu alleen aangeroepen vanuit de instellingenpagina (`leadtrackr.php:322`), dus uitsluitend in de admin. Er moet een `wp_enqueue_scripts`-hook bij.
3. **Dubbel schrijven voorkomen.** Draait er op dezelfde site óók een GTM-tag, dan schrijven twee implementaties naar dezelfde cookie. Beide zijn idempotent binnen een sessie — als `lt_session` bestaat komt er geen entry bij — dus dat gaat goed, maar het is het eerste om naar te kijken bij vreemd gedrag.
4. **Consent zonder GTM** volgens de keten in §7. Nooit gokken naar `granted`.
5. **Server-side blijven doorsturen mag.** De plugin kan `lt_channelflow` gewoon als string blijven meesturen; de backend normaliseert.
