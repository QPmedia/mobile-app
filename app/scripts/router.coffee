define (require) ->
	nav = require("navigator")
	List = require("views/list")
	Detail = require("views/detail")
	QponListView = require ("views/qpon_list")
	QponDetailView = require ("views/qpon_detail")

	# Defining the application router, you can attach sub routers here.
	class Router extends Backbone.Router
		initialize: (options) ->
			nav.init options

		routes:
			"!/animals": "list"
			"!/animals/:id": "detail"
			"!/coupons": "qpon_list"
			"!/coupons/:id": "qpon_detail"
			"*actions": "qpon_list"

		list: ->
			nav.changeView new List()

		detail: (id) ->
			nav.changeView new Detail(id: id)

		qpon_list: ->
			nav.changeView new QponListView()

		qpon_detail: (id) ->
			nav.changeView new QponDetailView(id: id)
