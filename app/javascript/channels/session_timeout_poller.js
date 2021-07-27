const sessionTimeoutPollFrequency = 5;
window.lastActive = new Date().valueOf();

['mousemove', 'scroll', 'click', 'keydown'].forEach((activity) => {
  document.addEventListener(activity, (ev) => {
    window.lastActive = ev.timeStamp + performance.timing.navigationStart;
  }, false);
});

function pollForSessionTimeout() {
  if ((Date.now() - window.heartBeat.lastActive) < (sessionTimeoutPollFrequency * 1000)) {
    return;
  }

  let request = new XMLHttpRequest();
  request.onload = function (event) {
    var status = event.target.status;
    var response = event.target.response;

    // if the remaining valid time for the current user session is less than or equals to 0 seconds.
    if (status === 200 && (response <= 0)) {
      window.location.href = '/session_timeout';
    }
  };
  request.open('GET', '/check_session_timeout', true);
  request.responseType = 'json';
  request.send();
  setTimeout(pollForSessionTimeout, (sessionTimeoutPollFrequency * 1000));
}