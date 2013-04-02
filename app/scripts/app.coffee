define (require) ->

	User = require("models/user")
	swig = require("swig")
	Backbone = require("backbone")
	Spine             = require("spine")
	require("spine/route")
	require("backbone-zombienation")
	require("backbone-fetch-cache")
	require("jquery-serialize-object")
	swig.init
		filters: require("utils/filter")


	#SettingsView      = require("views/settings")
	#LoginView         = require("views/login")
	#QponDetailView    = require("views/qpon_detail")
	#LazyListView      = require("views/lazy_list")
	#QponListView      = require("views/qpon_list")
	#StartView         = require("views/start")
	#Spine             = require("spine")

	class App extends Spine.Controller
		API_URL: "http://192.168.2.12:8000/m/api/"

		geolocation_watcher: null
		location: null

		constructor: ->
			# events mix-in; not a real class so we can't use 'extends'
			#_.extend @, Backbone.Events
			@geolocation_watcher = navigator.geolocation.watchPosition(
				@new_loc,
				@loc_err,
				timeout: 30000)
			navigator.geolocation.getCurrentPosition(@new_loc,@loc_err)
			@user = new User()
			url = localStorage.getItem("API_URL")
			if not (url is null)
				@API_URL = url
			# Setup App Events
			@on "alert", (msg) =>
				console.log(msg)
				r = confirm("UNAUTHORIZED")
				if r is true
					@router.navigate('!/login', {trigger: true})
				else
					console.log('try again')

			$(document).ajaxError (event, jqxhr, settings, exception) =>
				if exception is "UNAUTHORIZED"
					@trigger("alert", exception)



			@routes
				"/": -> console.log "RPUTE!!"
				"!/start":  -> console.log "start"
				"!/login":  -> @changeView require("views/settings")
				"!/settings":  -> console.log "settings"
				"!/coupons":  -> console.log "qpon_list"
				"!/lazylist":  -> console.log "lazy_list"
				"!/coupons/:id":  -> console.log "qpon_detail"
				"!/favorites":  -> console.log "favorite_list"
				"*actions":  -> @changeView require("views/start")



			console.log("app initialized")

		changeView: (view) ->
			newView = new view()
			# nested function just to be compatible, data should be a dict, handled inside the header
			newView.on("update_header", (data) => @header.setTitle(data.title))
			@menu.hide()
			@currentView.release() if @currentView and @currentView.release
			# backward compat for Backbone
			@currentView.dispose() if @currentView and @currentView.dispose
			@currentView = newView

			# Render the new view into our main DOM element
			# Note this used to use .html() instead of .empty().append()
			# But there is an issue with using .html():
			# http://tbranyen.com/post/missing-jquery-events-while-rendering
			@currentView.render()

			#$(this.container).html(this.currentView.el);
			$("#content").empty().append @currentView.el

		new_loc: (position) =>
			#alert "loc: #{position.coords.latitude},#{position.coords.longitude}"
			console.log( position.coords.latitude + "," + position.coords.longitude)
			@location = position
			@trigger "location_changed", position
		loc_err: =>
			alert "loc_err"
		sync_with_token: (method, model, options) =>
			token = "Token #{@user.get('token')}"
			options.beforeSend = (jqXHR) ->
				jqXHR.setRequestHeader('Authorization', token)
				#Call the default Backbone sync implementation
			Backbone.sync.call(this, method, model, options)

	# this is a singleton class
	# thanks to requirejs we always get the same object when using app = require(app)
	return new App()
