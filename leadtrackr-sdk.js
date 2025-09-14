(function() {
  window.leadtrackrSDK = window.leadtrackrSDK || {};

  /**
   * Deze functie verstuurt de lead data naar de LeadTrackr API.
   * @param {string} payloadString - De payload als een JSON-string.
   * @param {function} onSuccess - Callback functie voor succes.
   * @param {function} onFailure - Callback functie voor falen.
   */
  window.leadtrackrSDK.trackLead = function(payloadString, onSuccess, onFailure) {
    console.log('LeadTrackr SDK: trackLead function called.');
    var endpoint = 'https://app.leadtrackr.io/api/leads/createLead';
    var headers = {
      'Content-Type': 'application/json'
    };
    var payload;

    try {
        payload = JSON.parse(payloadString);
        console.log('LeadTrackr SDK: Successfully parsed payload.', payload);
    } catch (e) {
        console.error('LeadTrackr SDK: Failed to parse payload string.', e);
        if (typeof onFailure === 'function') {
            onFailure();
        }
        return;
    }

    // Gebruik de fetch API om de POST-aanroep te doen
    console.log('LeadTrackr SDK: Sending POST request to endpoint:', endpoint);
    fetch(endpoint, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(payload)
    })
    .then(function(response) {
      console.log('LeadTrackr SDK: Received response from API. Status:', response.status);
      if (response.ok) {
        console.log('LeadTrackr SDK: Lead successfully sent.');
        if (typeof onSuccess === 'function') {
            onSuccess();
        }
      } else {
        console.error('LeadTrackr SDK: Received a non-ok response.', response.status, response.statusText);
        response.json().then(errorData => {
            console.error('LeadTrackr SDK: Response body:', errorData);
        }).catch(() => {
            console.error('LeadTrackr SDK: Could not parse response body as JSON.');
        });
        if (typeof onFailure === 'function') {
            onFailure();
        }
      }
    })
    .catch(function(error) {
      console.error('LeadTrackr SDK: Failed to send lead. Error:', error);
      if (typeof onFailure === 'function') {
        onFailure();
      }
    });
  };
})();
