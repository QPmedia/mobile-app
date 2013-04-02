define ["views/qpon_list",
		"views/lazy_list",
		"views/qpon_detail",
		"views/start",
		"views/login",
		"views/favorite_list",
		"views/settings"]
		, (QponListView, LazyListView, QponDetailView, StartView, LoginView, FavoriteListView,
			SettingsView) ->
	# Defining the application router, you can attach sub routers here.
	class Router extends Backbone.Router
		initialize: (options) ->
			@container = options.container
			@menu = options.menu

		routes:
			"!/start": "start"
			"!/settings": "settings"
			"!/login": "login"
			"!/coupons": "qpon_list"
			"!/lazylist": "lazy_list"
			"!/coupons/:id": "qpon_detail"
			"!/favorites": "favorite_list"
			"*actions": "start"

		start: ->
			@changeView new StartView()

		settings: ->
			@changeView new SettingsView()

		login: ->
			@changeView new LoginView()

		qpon_list: ->
			@changeView new QponListView()

		lazy_list: ->
			@changeView new LazyListView()

		qpon_detail: (id) ->
			@changeView new QponDetailView(id: id)

		favorite_list: ->
			@changeView new FavoriteListView()



		# Swaps out the current view for the new one,
		# destroying the old view in the process.
		# TODO look into how to handle a page transition here!
		changeView: (newView) ->
			@menu.hide()
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

