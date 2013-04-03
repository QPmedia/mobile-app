define ["models/user",
		"utils/filter"
		"swig",
		"backbone",
		"backbone-zombienation",
		"backbone-fetch-cache",
		"jquery-serialize-object"]
		,(User, swig_filter, swig, Backbone) ->

	swig.init
		filters: swig_filter

	class App
		API_URL: "http://192.168.2.12:8000/m/api/"

		geolocation_watcher: null
		location: null

		constructor: ->
			# events mix-in; not a real class so we can't use 'extends'
			_.extend @, Backbone.Events
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

			console.log("app initialized")

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
