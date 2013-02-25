define (require) ->
	nav = require("navigator")
	List = require("views/list")
	Detail = require("views/detail")
	qponList = require ("views/qponList")

	# Defining the application router, you can attach sub routers here.
	class Router extends Backbone.Router
		initialize: (options) ->
			nav.init options

		routes:
			"!/animals": "list"
			"!/animals/:id": "detail"
			"!/coupons": "qponList"
			"*actions": "qponList"

		list: ->
			nav.changeView new List()

		detail: (id) ->
			nav.changeView new Detail(id: id)

		qponList: ->
			nav.changeView new qponList()
