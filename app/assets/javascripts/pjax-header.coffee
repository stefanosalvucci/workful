$ ->
  if history.pushState
    $.ajaxSetup
      headers: { 'X-Turbolinks': 'true' }
