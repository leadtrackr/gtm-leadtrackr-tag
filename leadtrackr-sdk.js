(function() {
  window.leadtrackrSDK = window.leadtrackrSDK || {};

  window.leadtrackrSDK.trackLead = function(payload) {
    var endpoint = 'https://app.leadtrackr.io/api/leads/createLead';
    var headers = {
      'Content-Type': 'application/json'
    };

    // Stuur een POST-aanroep met de payload in de body
    fetch(endpoint, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(payload)
    }).then(function(response) {
      // Optionele logica voor het omgaan met de respons
      console.log('LeadTrackr API response:', response);
    }).catch(function(error) {
      console.error('LeadTrackr API error:', error);
    });
  };
})();
