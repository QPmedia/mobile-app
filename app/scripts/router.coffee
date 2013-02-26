define (require) ->
	nav = require("navigator")
	QponListView = require ("views/qpon_list")
	QponDetailView = require ("views/qpon_detail")

	# Defining the application router, you can attach sub routers here.
	class Router extends Backbone.Router
		initialize: (options) ->
			nav.init options

		routes:
			"!/coupons": "qpon_list"
			"!/coupons/:id": "qpon_detail"
			"*actions": "qpon_list"

		qpon_list: ->
			nav.changeView new QponListView()

		qpon_detail: (id) ->
			nav.changeView new QponDetailView(id: id)
