(function() {
  window.leadtrackrSDK = window.leadtrackrSDK || {};

  /**
   * This function sends lead data to the LeadTrackr API.
   *
   * Rules:
   * - Payload must be valid JSON.
   * - A lead is only sent if at least one field exists in userData OR attributionData.
   * - If both userData and attributionData are missing or empty, the lead is blocked.
   *
   * @param {string} payloadString - The payload as a JSON string.
   * @param {function} onSuccess - Callback function for success.
   * @param {function} onFailure - Callback function for failure.
   */
  window.leadtrackrSDK.trackLead = function(payloadString, onSuccess, onFailure) {
    var endpoint = 'https://app.leadtrackr.io/api/leads/createLead';
    var headers = {
      'Content-Type': 'application/json'
    };
    var payload;

    try {
      payload = JSON.parse(payloadString);
    } catch (e) {
      console.error('LeadTrackr SDK: Failed to parse payload string.', e);
      if (typeof onFailure === 'function') onFailure();
      return;
    }

    // Basic validation: payload must be an object
    if (!payload || typeof payload !== 'object' || Array.isArray(payload)) {
      console.warn('LeadTrackr SDK: Invalid payload object.', payload);
      if (typeof onFailure === 'function') onFailure();
      return;
    }

    // template.tpl uses camelCase: userData / attributionData
    var hasUserData =
      payload.userData &&
      typeof payload.userData === 'object' &&
      !Array.isArray(payload.userData) &&
      Object.keys(payload.userData).length > 0;

    var hasAttributionData =
      payload.attributionData &&
      typeof payload.attributionData === 'object' &&
      !Array.isArray(payload.attributionData) &&
      Object.keys(payload.attributionData).length > 0;

    // Block lead if both userData and attributionData are missing or empty
    if (!hasUserData && !hasAttributionData) {
      console.warn(
        'LeadTrackr SDK: Blocked lead, missing userData and attributionData (both empty or absent).',
        payload
      );
      if (typeof onFailure === 'function') onFailure();
      return;
    }

    // Send the lead to the API
    fetch(endpoint, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(payload)
    })
    .then(function(response) {
      if (response.ok) {
        if (typeof onSuccess === 'function') onSuccess();
      } else {
        console.error(
          'LeadTrackr SDK: Received a non-ok response.',
          response.status,
          response.statusText
        );
        response.json()
          .then(function(errorData) {
            console.error('LeadTrackr SDK: Response body:', errorData);
          })
          .catch(function() {
            console.error('LeadTrackr SDK: Could not parse response body as JSON.');
          });

        if (typeof onFailure === 'function') onFailure();
      }
    })
    .catch(function(error) {
      console.error('LeadTrackr SDK: Failed to send lead. Error:', error);
      if (typeof onFailure === 'function') onFailure();
    });
  };
})();
