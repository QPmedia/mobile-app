define (require) ->
	nav = require("navigator")
	QponListView = require ("views/qpon_list")
	QponDetailView = require ("views/qpon_detail")
	StartView = require("views/start")
	LoginView = require("views/login")

	# Defining the application router, you can attach sub routers here.
	class Router extends Backbone.Router
		initialize: (options) ->
			nav.init options

		routes:
			"!/start": "start"
			"!/login": "login"
			"!/coupons": "qpon_list"
			"!/coupons/:id": "qpon_detail"
			"*actions": "start"

		start: ->
			nav.changeView new StartView()

		login: ->
			nav.changeView new LoginView()

		qpon_list: ->
			nav.changeView new QponListView()

		qpon_detail: (id) ->
			nav.changeView new QponDetailView(id: id)
