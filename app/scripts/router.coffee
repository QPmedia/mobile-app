define ["jquery",
		"views/qpon_list",
		"views/qpon_detail",
		"views/start",
		"views/login",
		"views/favorite_list"]
		, ($, QponListView, QponDetailView, StartView, LoginView, FavoriteListView) ->

	# Defining the application router, you can attach sub routers here.
	class Router extends Backbone.Router
		initialize: (options) ->
			@container = options.container

		routes:
			"!/start": "start"
			"!/login": "login"
			"!/coupons": "qpon_list"
			"!/coupons/:id": "qpon_detail"
			"!/favorites": "favorite_list"
			"*actions": "start"

		start: ->
			@changeView new StartView()

		login: ->
			@changeView new LoginView()

		qpon_list: ->
			@changeView new QponListView()

		qpon_detail: (id) ->
			@changeView new QponDetailView(id: id)

		favorite_list: ->
			@changeView new FavoriteListView()



		# Swaps out the current view for the new one,
		# destroying the old view in the process.
		# TODO look into how to handle a page transition here!
		changeView: (newView) ->
			@currentView.dispose()  if @currentView and @currentView.dispose
			@currentView = newView

			# Render the new view into our main DOM element
			# Note this used to use .html() instead of .empty().append()
			# But there is an issue with using .html():
			# http://tbranyen.com/post/missing-jquery-events-while-rendering
			@currentView.render()

			#$(this.container).html(this.currentView.el);
			$(@container).empty().append @currentView.el

			# Let the view know we have finished rendering.
			#TODO: mboehme: re-enable this
			#@currentView.wasRendered()

