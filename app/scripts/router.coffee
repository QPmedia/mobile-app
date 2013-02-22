define (require) ->
	nav = require("navigator")
	List = require("views/list")
	Detail = require("views/detail")

	# Defining the application router, you can attach sub routers here.
	class Router extends Backbone.Router
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
