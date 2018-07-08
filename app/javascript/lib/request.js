export const postRequest = (url, csrf_token, params, callback, context) => {
  fetch(url, {
    method: 'POST',
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': csrf_token,
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    body: params,
    credentials: 'same-origin'
  }).then((response) => {return response.json()})
  .then((response) => {
    callback(response, context);
  })
};
