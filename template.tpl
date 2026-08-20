___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_PLF4T",
  "version": 1,
  "displayName": "LeadTracker Tag",
  "brand": {
    "id": "github.com_leadtrackr",
    "displayName": "leadtrackr",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHgAAAB4CAYAAAA5ZDbSAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHySURBVHgB7dsxSgNBGEDhf7PRpMwRkht4BUtBIWrjMWwtAgEDlrmCpYUoQsRSr+AJkhuorYkZcwCLERZ2efu+YqppZt4yzcxGSJIkSZLUHkXOpLPFbBmRhqHGeDieZLXrhNAMDGdgOAPDGRjOwHAGhjMwnIHhDAxnYDgDwxkYzsBwBoYzMJyB4QwMZ2C4bs6k/bI8jAZbb7fzlLbjqEiK9NQr9y4DICvw3dHVKhrsdHH9lfUCLVOn6Hw0fc25PKLhDAxnYDgDwxkYzsBwBoYzMJyB4QwMZ2A4A8MZGM7AcAaGMzBc1oX/xcvNMCpEuUzPNX6cDvr93iAqlLuHWYG/fzbLqNDugxm1KXK3Wx7s9vA1KlOsdsMoZ6ZHNJyB4QwMZ2A4A8MZGM7AcAaGMzCcgeEMDGdgOAPDGRjOwHAGhjMwnIHhDAxnYDgDwxkYzsBwBoYzMFzWnw1NV6ZYpaJ4i4qkFO8BgQh8fzKZhv7kEQ1nYDgDwxkYzsBwBoYzMJyB4QwMZ2A4A8MZGM7AcAaGMzCcgeFqufBfbzfz8+fZZ7REijTYDbWoJXBKMY66VtwyHtFwBoYzMJyB4QwMZ2A4A8MZGM7AcAaGMzCcgeEMDGdgOAPDGRjOwHAGhst6slMUxW2oMVKK1rxnkyRJkiTpP34BF81FRmRdjK0AAAAASUVORK5CYII\u003d"
  },
  "description": "This tag tracks the customer journey, capturing UTMs and referrer data. It also allows you to send lead data to the Leadtrackr API with custom fields, user data, and channel history.",
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "tagType",
    "displayName": "Tag Type",
    "radioItems": [
      {
        "value": "pageview",
        "displayValue": "Channel Flow Tracker (pageview/config)"
      },
      {
        "value": "lead",
        "displayValue": "Lead"
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "projectId",
    "displayName": "Project ID",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "lead",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "formData",
    "displayName": "Form Data",
    "groupStyle": "ZIPPY_OPEN",
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "lead",
        "type": "EQUALS"
      }
    ],
    "subParams": [
      {
        "type": "TEXT",
        "name": "formName",
        "displayName": "Form Name",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "dedupEnabled",
        "checkboxText": "Enable Lead Deduplication",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "uniqueEventId",
        "displayName": "Unique Event ID",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "dedupEnabled",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "userData",
    "displayName": "User Data",
    "groupStyle": "ZIPPY_OPEN",
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "lead",
        "type": "EQUALS"
      }
    ],
    "subParams": [
      {
        "type": "SELECT",
        "name": "userProvidedData",
        "displayName": "User-Provided Data Object",
        "macrosInSelect": true,
        "selectItems": [],
        "simpleValueType": true,
        "notSetText": "(not set)",
        "help": "Provide a User-Provided Data Object to be merged with the fields below.\nIf any properties overlap, the values defined in the table below will override those in your provided object."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "userDataFields",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Key",
            "name": "key",
            "type": "SELECT",
            "selectItems": [
              {
                "value": "firstName",
                "displayValue": "First Name"
              },
              {
                "value": "lastName",
                "displayValue": "Last Name"
              },
              {
                "value": "phone",
                "displayValue": "Phone Number"
              },
              {
                "value": "email",
                "displayValue": "Email Address"
              },
              {
                "value": "companyName",
                "displayValue": "Company Name"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "Add Value"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "formFields",
    "displayName": "Custom Form Fields",
    "groupStyle": "ZIPPY_OPEN",
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "lead",
        "type": "EQUALS"
      }
    ],
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "formFieldsData",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Key",
            "name": "key",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "Add Value"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "sessionTimeoutMinutes",
    "displayName": "Session Timeout (minutes)",
    "simpleValueType": true,
    "defaultValue": 30,
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "pageview",
        "type": "EQUALS"
      }
    ],
    "help": "A new Channel Flow entry is recorded when this many minutes pass without a pageview. Matches the GA4 default of 30 minutes."
  },
  {
    "type": "CHECKBOX",
    "name": "enableCustomUtm",
    "checkboxText": "Use Custom UTM Parameters",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "pageview",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "channel_parameters",
    "displayName": "Custom UTM Parameters",
    "description": "Enter the names of custom URL parameters you want to use here. Leave them blank to use the standard UTM parameters.",
    "subParams": [
      {
        "type": "TEXT",
        "name": "sourceParam",
        "displayName": "Source Parameter",
        "simpleValue": true,
        "defaultValue": "utm_source"
      },
      {
        "type": "TEXT",
        "name": "mediumParam",
        "displayName": "Medium Parameter",
        "simpleValue": true,
        "defaultValue": "utm_medium"
      },
      {
        "type": "TEXT",
        "name": "campaignParam",
        "displayName": "Campaign Parameter",
        "simpleValue": true,
        "defaultValue": "utm_campaign"
      },
      {
        "type": "TEXT",
        "name": "contentParam",
        "displayName": "Content Parameter",
        "simpleValue": true,
        "defaultValue": "utm_content"
      },
      {
        "type": "TEXT",
        "name": "termParam",
        "simpleValue": true,
        "defaultValue": "utm_term",
        "displayName": "Term Parameter"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "enableCustomUtm",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "isDebug",
    "checkboxText": "Enable debug mode",
    "simpleValueType": true,
    "defaultValue": false
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/* eslint-env gtm */

const getQueryParameters = require('getQueryParameters');
const getCookieValues = require('getCookieValues');
const setCookie = require('setCookie');
const getTimestamp = require('getTimestamp');
const JSON = require('JSON');
const getReferrerUrl = require('getReferrerUrl');
const getUrl = require('getUrl');
const queryPermission = require('queryPermission');
const logToConsole = require('logToConsole');
const injectScript = require('injectScript');
const callInWindow = require('callInWindow');
const encodeUriComponent = require('encodeUriComponent');
const readAnalyticsStorage = require('readAnalyticsStorage');
const isConsentGranted = require('isConsentGranted');
const makeNumber = require('makeNumber');
const getType = require('getType');

let pageLocation = getUrl();

if (
  pageLocation &&
  pageLocation.lastIndexOf('https://gtm-msr.appspot.com/', 0) === 0
) {
  data.gtmOnSuccess();

  return;
}

const cookieName = 'lt_channelflow';
const sessionCookieName = 'lt_session';
const maxAgeSeconds = 395 * 86400;
const defaultTimeoutMinutes = 30;

// A Channel Flow entry marks the start of a session, so the array only grows
// for returning visitors. Both limits guard the 4KB browser cookie limit: past
// it the cookie is silently rejected and the whole journey is lost.
const maxEntries = 25;
const maxCookieLength = 3500;

const searchEngineLabels = ['google', 'bing', 'yahoo', 'duckduckgo', 'baidu', 'ecosia', 'yandex', 'startpage', 'qwant', 'brave', 'naver'];
const secondLevelDomains = ['co', 'com', 'org', 'net', 'gov', 'edu', 'ac', 'mil'];
const googleClickIds = ['gclid', 'gbraid', 'wbraid'];
const consentTypes = ['ad_storage', 'analytics_storage', 'ad_user_data', 'ad_personalization'];

function getSubDomainIndex() {
  const hostname = getUrl('hostname');
  if (!hostname) return 1;

  const parts = hostname.split('.');
  if (parts.length > 2) {
    return parts.length - 1;
  }
  return 1;
}

// Returns the registrable part of a host: www.google.nl -> google.nl,
// www.google.co.uk -> google.co.uk. Matching on this instead of the full host
// is what makes every country domain resolve to the same search engine.
function registrableDomain(host) {
  if (!host) return '';
  const parts = host.split('.');
  if (parts.length <= 2) return host;

  let take = 2;
  const secondLast = parts[parts.length - 2];
  for (const sld of secondLevelDomains) {
    if (secondLast === sld) {
      take = 3;
      break;
    }
  }
  if (parts.length <= take) return host;
  return parts.slice(parts.length - take).join('.');
}

function domainLabel(host) {
  const registrable = registrableDomain(host);
  if (!registrable) return '';
  return registrable.split('.')[0];
}

function getUtmMapping() {
  return {
    s: data.sourceParam || 'utm_source',
    m: data.mediumParam || 'utm_medium',
    cm: data.campaignParam || 'utm_campaign',
    ct: data.contentParam || 'utm_content',
    tm: data.termParam || 'utm_term',
  };
}

function getUtmChannel() {
  const mapping = getUtmMapping();
  const channel = {};
  let hasAny = false;

  for (const key in mapping) {
    const value = getQueryParameters(mapping[key]);
    if (value) {
      channel[key] = value;
      hasAny = true;
    }
  }
  if (!hasAny) return null;

  if (!channel.s) channel.s = '(not set)';
  if (!channel.m) channel.m = '(not set)';
  return channel;
}

// Click IDs count only when present in this pageview's query string. Reading
// them from _gcl_aw would mark every later visit as paid for 90 days.
function getClickIdChannel() {
  for (const param of googleClickIds) {
    if (getQueryParameters(param)) {
      return { s: 'google', m: 'cpc' };
    }
  }
  if (getQueryParameters('msclkid')) {
    return { s: 'bing', m: 'cpc' };
  }
  return null;
}

function getReferrerHost() {
  if (!queryPermission('get_referrer', 'host')) return null;
  return getReferrerUrl('host');
}

function getCurrentHost() {
  if (!queryPermission('get_url', 'host')) return null;
  return getUrl('host');
}

// An empty referrer is not internal: a real ad click can arrive without one.
function isInternalReferrer() {
  const referrerHost = getReferrerHost();
  if (!referrerHost) return false;
  return registrableDomain(referrerHost) === registrableDomain(getCurrentHost());
}

function resolveChannel(utmChannel, clickIdChannel) {
  if (utmChannel) return utmChannel;
  if (clickIdChannel) return clickIdChannel;

  const referrerHost = getReferrerHost();

  // Compared on domain level so a hop between subdomains stays internal.
  if (referrerHost && registrableDomain(referrerHost) !== registrableDomain(getCurrentHost())) {
    const label = domainLabel(referrerHost);
    for (const engine of searchEngineLabels) {
      if (label === engine) {
        return { s: label, m: 'organic' };
      }
    }
    return { s: referrerHost, m: 'referral' };
  }

  return { s: 'direct', m: 'none' };
}

function sameChannel(a, b) {
  if (!a || !b) return false;
  const keys = ['s', 'm', 'cm', 'ct', 'tm'];
  for (const key of keys) {
    if ((a[key] || '') !== (b[key] || '')) return false;
  }
  return true;
}

function getLandingPath() {
  if (!queryPermission('get_url', 'path')) return '';
  const path = getUrl('path') || '';
  if (path.length > 100) return path.substring(0, 100);
  return path;
}

// Accepts both the compact format and the original one still living in
// cookies out in the field, so existing journeys survive the upgrade.
function toCompactEntry(entry) {
  if (!entry) return null;
  if (entry.t && entry.ch) return entry;

  if (entry.timestamp && entry.channel) {
    const legacy = entry.channel;
    const channel = {};
    if (legacy.source) channel.s = legacy.source;
    if (legacy.medium) channel.m = legacy.medium;
    if (legacy.campaign) channel.cm = legacy.campaign;
    if (legacy.content) channel.ct = legacy.content;
    if (legacy.term) channel.tm = legacy.term;
    return { t: entry.timestamp, ch: channel };
  }
  return null;
}

function readChannelFlow() {
  const existingCookie = getCookieValues(cookieName);
  const cookieValue = (existingCookie && existingCookie.length > 0) ? existingCookie[0] : null;
  if (!cookieValue || cookieValue.charAt(0) !== '[') return [];

  const parsedCookie = JSON.parse(cookieValue);
  if (!parsedCookie) {
    if (data.isDebug) {
      logToConsole('LeadTrackr: invalid JSON in lt_channelflow, starting a new channel flow.');
    }
    return [];
  }

  const flow = [];
  for (const entry of parsedCookie) {
    const compact = toCompactEntry(entry);
    if (compact) flow.push(compact);
  }
  return flow;
}

// Always drops the second entry, never the first: the first touch is what
// makes first-touch attribution possible.
function applyLimits(flow) {
  while (flow.length > maxEntries && flow.length > 1) {
    flow.splice(1, 1);
  }
  // The cookie is stored URL encoded, so that is the length that counts.
  while (flow.length > 1 && encodeUriComponent(JSON.stringify(flow)).length > maxCookieLength) {
    flow.splice(1, 1);
  }
  return flow;
}

function getSessionTimeoutSeconds() {
  let minutes = defaultTimeoutMinutes;
  if (data.sessionTimeoutMinutes) {
    const parsed = makeNumber(data.sessionTimeoutMinutes);
    if (parsed && parsed > 0) minutes = parsed;
  }
  return minutes * 60;
}

function updateChannelFlow() {
  const flow = readChannelFlow();
  const sessionCookie = getCookieValues(sessionCookieName);
  const sessionActive = !!(sessionCookie && sessionCookie.length > 0);

  // A click ID behind an internal referrer was carried over, not clicked:
  // consent mode's url_passthrough appends it to every internal link once
  // ad_storage is denied. Without this each expired session would record
  // another paid touchpoint that never happened.
  const utmChannel = getUtmChannel();
  const clickIdChannel = isInternalReferrer() ? null : getClickIdChannel();

  const channel = resolveChannel(utmChannel, clickIdChannel);
  const hasCampaignSignal = !!utmChannel || !!clickIdChannel;
  const lastEntry = flow.length > 0 ? flow[flow.length - 1] : null;

  let isNewSession = false;
  if (!lastEntry) {
    isNewSession = true;
  } else if (!sessionActive) {
    isNewSession = true;
  } else if (hasCampaignSignal && !sameChannel(lastEntry.ch, channel)) {
    isNewSession = true;
  }

  if (isNewSession) {
    const entry = { t: getTimestamp(), ch: channel };
    const landingPath = getLandingPath();
    if (landingPath) entry.lp = landingPath;
    flow.push(entry);
    applyLimits(flow);
  }

  if (data.isDebug) {
    logToConsole('LeadTrackr Channel Flow', {
      newSession: isNewSession,
      sessionActive: sessionActive,
      channel: channel,
      entries: flow.length
    });
  }

  setCookie(cookieName, JSON.stringify(flow), {
    'max-age': maxAgeSeconds,
    path: '/',
    domain: 'auto',
  });

  // Its existence is the session signal; expiry is left to the browser.
  setCookie(sessionCookieName, '1', {
    'max-age': getSessionTimeoutSeconds(),
    path: '/',
    domain: 'auto',
  });
}

function getConversionPage() {
  let host = '';
  if (queryPermission('get_url', 'host')) {
    host = getUrl('host') || '';
  }
  let path = '';
  if (queryPermission('get_url', 'path')) {
    path = getUrl('path') || '';
  }
  return host + path;
}

// Observational only: the CMP is responsible for blocking, this records what
// the state was. The API returns a boolean, so an unconfigured consent mode
// reads as granted.
function getConsentState() {
  const state = {};
  for (const consentType of consentTypes) {
    state[consentType] = isConsentGranted(consentType) ? 'granted' : 'denied';
  }
  return state;
}


// GTM's built in User-Provided Data variable wraps these fields in an array,
// a hand built dataLayer object passes them as plain values. Both reach this
// tag, so every read goes through here.
function firstValue(value) {
  if (getType(value) === 'array') {
    return value.length > 0 ? value[0] : null;
  }
  return value;
}

function sendLeadData() {
  const payload = {};
  payload.projectId = data.projectId;
  payload.formData = {
    formName: data.formName || 'undefined form name'
  };
  if (data.dedupEnabled && data.uniqueEventId) {
    payload.formData.uniqueEventId = data.uniqueEventId;
  }

  payload.userData = {};
  
  if (data.userProvidedData && getType(data.userProvidedData) === 'object') {
    const upd = data.userProvidedData;

    const email = firstValue(upd.email);
    if (email) {
      payload.userData.email = email;
    }

    const phone = firstValue(upd.phone_number);
    if (phone) {
      payload.userData.phone = phone;
    }

    const address = firstValue(upd.address);
    if (address && getType(address) === 'object') {
      if (address.first_name) {
        payload.userData.firstName = address.first_name;
      }
      if (address.last_name) {
        payload.userData.lastName = address.last_name;
      }
    }
  }

  if (data.userDataFields) {
    for (let key in data.userDataFields) {
      payload.userData[data.userDataFields[key].key] = data.userDataFields[key].value;
    }
  }

  if (data.formFieldsData) {
    payload.formData.formFields = {};
    for (let key in data.formFieldsData) {
      payload.formData.formFields[data.formFieldsData[key].key] = data.formFieldsData[key].value;
    }
  }

  const channelFlow = readChannelFlow();
  if (channelFlow.length > 0) {
    payload.channelFlow = channelFlow;
  }


  let gclid = getQueryParameters('gclid');
  let wbraid = getQueryParameters('wbraid');

  if (!gclid) {
    const gclAwCookie = getCookieValues('_gcl_aw')[0];
    gclid = gclAwCookie ? gclAwCookie.split('.')[2] : '';
  }

  if (!wbraid) {
    const gclGbCookie = getCookieValues('_gcl_gb')[0];
    wbraid = gclGbCookie ? gclGbCookie.split('.')[2] : '';
  }

  let fbc = getCookieValues('_fbc')[0] || '';
  const fbclid = getQueryParameters('fbclid');

  if (fbclid) {
    const currentFbcId = fbc.split('.').pop();
    if (!fbc || (fbc && currentFbcId !== fbclid)) {
      const subDomainIndex = getSubDomainIndex();
      const timestamp = getTimestamp();
      fbc =
        'fb.' +
        subDomainIndex +
        '.' +
        timestamp +
        '.' +
        encodeUriComponent(fbclid);
    }
  }

  let fbp = getCookieValues('_fbp')[0] || '';

  let cid = '';
  if (readAnalyticsStorage) {
    const analyticsStorageData = readAnalyticsStorage();
    cid = analyticsStorageData.client_id || '';
  }


  // conversionPage and consent ride along inside attributionData: createLead
  // only destructures known top-level fields, and attributionData is merged
  // rather than overwritten when a lead is updated.
  payload.attributionData = {
    fbc: fbc,
    fbp: fbp,
    gclid: gclid,
    wbraid: wbraid,
    cid: cid,
    conversionPage: getConversionPage(),
    consent: getConsentState()
  };


  injectScript('https://cdn.jsdelivr.net/gh/leadtrackr/gtm-leadtrackr-tag@main/leadtrackr-sdk.js', () => {
    callInWindow('leadtrackrSDK.trackLead', JSON.stringify(payload), data.gtmOnSuccess, data.gtmOnFailure);
  }, () => {
    data.gtmOnFailure();
  });
}

if (data.tagType === 'pageview') {
  updateChannelFlow();
  data.gtmOnSuccess();
} else if (data.tagType === 'lead') {
  sendLeadData();
} else {
  data.gtmOnFailure();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "lt_channelflow"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "lt_session"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "leadtrackrSDK"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "leadtrackrSDK.trackLead"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cdn.jsdelivr.net/gh/leadtrackr/gtm-leadtrackr-tag@main/*.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_analytics_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 29-8-2025, 13:21:16
