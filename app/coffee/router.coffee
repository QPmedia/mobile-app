define (require) ->
  nav = require("navigator")
  List = require("modules/list")
  Detail = require("modules/detail")
  
  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend(
    initialize: (options) ->
      nav.init options

    routes:
      "!/animals": "list"
      "!/animals/:id": "detail"
      "*actions": "list"

    list: ->
      nav.changeView new List()

    detail: (id) ->
      nav.changeView new Detail(id: id)
  )
  Router
