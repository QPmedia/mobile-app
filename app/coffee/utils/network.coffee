define (require) ->
  $ = require("zepto")
  app = require("app")
  namespace = "network"
  _status = (if window.navigator and window.navigator.onLine then "online" else "offline")
  _onChanged = (stat) ->
    _status = stat
    app.trigger namespace + ":" + stat
    app.trigger namespace + ":change", stat

  withNetwork = (options) ->
    options[_status].apply()  if _.isFunction(options[_status])

  
  # Hook into the browser's 'online' and 'offline' events and subsequently fire app:events!
  _.each ["online", "offline"], (status) ->
    $(window).on status, (evt) ->
      _onChanged status


  exports = with: withNetwork
  app.registerModule namespace, exports
  exports
