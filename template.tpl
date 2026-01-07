___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "LeadTracker Tag",
  "brand": {
    "id": "brand_dummy",
    "displayName": "LeadTrackr",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHgAAAB4CAYAAAA5ZDbSAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHySURBVHgB7dsxSgNBGEDhf7PRpMwRkht4BUtBIWrjMWwtAgEDlrmCpYUoQsRSr+AJkhuorYkZcwCLERZ2efu+YqppZt4yzcxGSJIkSZLUHkXOpLPFbBmRhqHGeDieZLXrhNAMDGdgOAPDGRjOwHAGhjMwnIHhDAxnYDgDwxkYzsBwBoYzMJyB4QwMZ2C4bs6k/bI8jAZbb7fzlLbjqEiK9NQr9y4DICvw3dHVKhrsdHH9lfUCLVOn6Hw0fc25PKLhDAxnYDgDwxkYzsBwBoYzMJyB4QwMZ2A4A8MZGM7AcAaGMzBc1oX/xcvNMCpEuUzPNX6cDvr93iAqlLuHWYG/fzbLqNDugxm1KXK3Wx7s9vA1KlOsdsMoZ6ZHNJyB4QwMZ2A4A8MZGM7AcAaGMzCcgeEMDGdgOAPDGRjOwHAGhjMwnIHhDAxnYDgDwxkYzsBwBoYzMFzWnw1NV6ZYpaJ4i4qkFO8BgQh8fzKZhv7kEQ1nYDgDwxkYzsBwBoYzMJyB4QwMZ2A4A8MZGM7AcAaGMzCcgeFqufBfbzfz8+fZZ7REijTYDbWoJXBKMY66VtwyHtFwBoYzMJyB4QwMZ2A4A8MZGM7AcAaGMzCcgeEMDGdgOAPDGRjOwHAGhst6slMUxW2oMVKK1rxnkyRJkiTpP34BF81FRmRdjK0AAAAASUVORK5CYII\u003d"
  },
  "description": "This tag tracks the customer journey, capturing UTMs and referrer data. It also allows you to send lead data to the Leadtrackr API with custom fields, user data, and channel history.",
  "containerContexts": [
    "WEB"
  ]
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

const cookieName = 'lt_channelflow';
const maxAgeSeconds = 395 * 86400;
const organicSearchEngines = ['google.com', 'bing.com', 'yahoo.com', 'duckduckgo.com', 'baidu.com'];

function getSubDomainIndex() {
  const hostname = getUrl('hostname');
  if (!hostname) return 1;

  const parts = hostname.split('.');
  if (parts.length > 2) {
    return parts.length - 1;
  }
  return 1;
}

function getDomainFromHost(host) {
  if (!host) return null;
  const parts = host.split('.');
  if (parts.length >= 2) {
    return parts[parts.length - 2]; 
  }
  return host;
}

function getChannelData() {
  const utmMapping = {
    source: data.sourceParam || 'utm_source',
    medium: data.mediumParam || 'utm_medium',
    campaign: data.campaignParam || 'utm_campaign',
    content: data.contentParam || 'utm_content',
    term: data.termParam || 'utm_term',
  };
  const utm = {
    source: getQueryParameters(utmMapping.source) || '',
    medium: getQueryParameters(utmMapping.medium) || '',
    campaign: getQueryParameters(utmMapping.campaign) || '',
    content: getQueryParameters(utmMapping.content) || '',
    term: getQueryParameters(utmMapping.term) || '',
  };
    
  let referrerHost = null;
  if (queryPermission('get_referrer', 'host')) {
    referrerHost = getReferrerUrl('host');
  }
  let currentHost = null;
  if (queryPermission('get_url', 'host')) {
    currentHost = getUrl('host');
  }

  let hasAnyUtm = false;
  for (const key in utm) {
    if (utm[key]) {
      hasAnyUtm = true;
      break;
    }
  }

  if (hasAnyUtm) return utm;
  if (referrerHost) {
    for (const engine of organicSearchEngines) {
      if (referrerHost.indexOf(engine) > -1) {
        return {
          source: getDomainFromHost(referrerHost) || '(not set)',
          medium: 'organic'
        };
      }
    }
    if (currentHost && referrerHost !== currentHost) {
      return {
        source: referrerHost || '(not set)',
        medium: 'referral'
      };
    }
  }

  return {
    source: 'direct',
    medium: 'none'
  };
}

function updateChannelFlow() {
  const existingCookie = getCookieValues(cookieName);
  let channelFlow = [];
  const cookieValue = (existingCookie && existingCookie.length > 0) ? existingCookie[0] : null;

  if (cookieValue && cookieValue.charAt(0) === '[') {
    const parsedCookie = JSON.parse(cookieValue);
    if (parsedCookie) {
      channelFlow = parsedCookie;
    } else if (data.isDebug) {
      logToConsole('Ongeldige JSON in de ChannelFlow cookie. De cookie zal opnieuw worden gezet.');
    }
  }

  let currentChannelData;
  const lastEntry = channelFlow[channelFlow.length - 1];
    
  const utmMapping = {
    source: data.sourceParam || 'utm_source',
    medium: data.mediumParam || 'utm_medium',
    campaign: data.campaignParam || 'utm_campaign',
    content: data.contentParam || 'utm_content',
    term: data.termParam || 'utm_term',
  };
  let hasNewUtmParams = false;
  for (const key in utmMapping) {
    if (getQueryParameters(utmMapping[key])) {
      hasNewUtmParams = true;
      break;
    }
  }
    
  if (channelFlow.length > 0 && !hasNewUtmParams) {
    currentChannelData = lastEntry.channel;
  } else {
    currentChannelData = getChannelData();
  }

  const newEntry = {
    timestamp: getTimestamp(),
    channel: currentChannelData
  };
    
  const isSameEntry = lastEntry && JSON.stringify(lastEntry.channel) === JSON.stringify(newEntry.channel);
  if (!isSameEntry) {
    channelFlow.push(newEntry);
  }

  setCookie(cookieName, JSON.stringify(channelFlow), {
    'max-age': maxAgeSeconds,
    path: '/',
    domain: 'auto',
  });
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
  
  if (data.userProvidedData && typeof data.userProvidedData === 'object') {
    const upd = data.userProvidedData;
    
    if (upd.email) {
      payload.userData.email = upd.email;
    }
    if (upd.phone_number) {
      payload.userData.phone = upd.phone_number;
    }
    
    if (upd.address && upd.address.length > 0) {
      const address = upd.address[0];
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

  let channelFlowCookieValue = getCookieValues(cookieName)[0];
  if (channelFlowCookieValue && channelFlowCookieValue.charAt(0) === '[') {
    const parsedCookie = JSON.parse(channelFlowCookieValue);
    if (parsedCookie) {
      payload.channelFlow = parsedCookie;
    } else if (data.isDebug) {
      logToConsole('Ongeldige JSON in de ChannelFlow cookie bij het versturen van lead data.');
    }
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


  payload.attributionData = {
    fbc: fbc,
    fbp: fbp,
    gclid: gclid,
    wbraid: wbraid,
    cid: cid
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
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 29-8-2025, 13:21:16

