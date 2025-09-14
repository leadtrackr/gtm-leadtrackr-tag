# Leadtrackr GTM Community Template

This is a Google Tag Manager community template for tracking customer journeys and sending lead data to Leadtrackr.io.

## Features

- **Channel Flow Tracker:** Captures UTM parameters, organic traffic, and referrer data to build a full customer journey history.
- **Lead Data Submission:** Sends lead information directly to the Leadtrackr API for lead attribution and tracking.
- **Flexible Configuration:** Supports custom form fields and user data to ensure all relevant information is captured.

## Installation

1.  **Download the Template:**
    Download the `template.tpl` file from this repository.

2.  **Import the Template in GTM:**
    -   In your Google Tag Manager container, navigate to the **Templates** section.
    -   Under "Tag Templates," click **New**.
    -   Click the three vertical dots in the top-right corner and select **Import**.
    -   Choose the `template.tpl` file you downloaded.

3.  **Create the Tag:**
    -   Go to **Tags** and click **New**.
    -   Choose the "Test new" tag from the "Custom" section.
    -   Configure the tag settings as needed, based on the options below.

## Configuration

The tag has two main modes, which you can select under the **Tag Type** setting.

### 1. Channel Flow Tracker (pageview/config)

This mode is used to track the user's channel history. It should be fired on every pageview to build the `lt_channelflow` cookie.

-   **Tag Type:** `Channel Flow Tracker (pageview/config)`
-   **Trigger:** All Pages (`Page View` trigger)

### 2. Lead

This mode is used to send lead data to the Leadtrackr API. This should be triggered on a lead event, such as a form submission.

-   **Tag Type:** `Lead`
-   **Project ID:** Your unique Leadtrackr Project ID.
-   **Form Data:**
    -   **Form Name:** A descriptive name for the form (e.g., `Contact Form`, `Demo Request`).
    -   **Enable Lead Deduplication:** (Optional) If enabled, a `Unique Event ID` field will appear.
    -   **Unique Event ID:** (Optional) A unique ID to prevent duplicate leads.
-   **User Data:** Map standard user data fields (e.g., `First Name`, `Email Address`) to their corresponding data layer variables or static values.
-   **Custom Form Fields:** Use this table to send any additional custom form data that you need to track.

### Permissions

This template requires the following permissions, which are automatically detected by GTM:
-   `get_cookies`
-   `set_cookies`
-   `get_url`
-   `get_referrer`
-   `logging` (in debug mode)
-   `inject_script`
-   `access_globals`


## Contribution

If you have suggestions for improvements or encounter bugs, feel free to open an issue or submit a pull request.

---

_This template is maintained by LeadTrackr and is not an official product of Google Tag Manager._
