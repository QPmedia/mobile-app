define (require) ->
  _ = require("lodash")
  Backbone = require("backbone")
  
  # Convenience function for registering a method as an event
  _registerWith = (app, namespace, context) ->
    (item, key) ->
      if _.isFunction(item)
        
        # Add an event listener on this function which
        # can be accessed via app.trigger() at any time
        app.on namespace + ":" + key, ->
          item.apply context, arguments_


  _.extend
    publish: (key) ->

    
    # A way to regiter modules for application-wide events.
    registerModule: (namespace, module, context) ->
      that = this
      context = module  unless context
      
      # Register each function in the module
      # as an event that can be called
      # via app.trigger() at a later date
      _.each module, _registerWith(this, namespace, context)
  , Backbone.Events

