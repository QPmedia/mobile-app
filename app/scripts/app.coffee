define ["models/user",
		"swig",
		"backbone",
		"backbone-tastypie",
		"backbone-zombienation",
		"backbone-fetch-cache"]
		,(User, swig, Backbone) ->
	swig.init
		filters: require("utils/filter")

	class App
		API_URL: "http://192.168.2.12:8000/m/api/v1/"

		constructor: ->
			# events mix-in; not a real class so we can't use 'extends'
			_.extend @, Backbone.Events

			@user = new User({API_URL:@API_URL})

			# Setup App Events
			@on "alert", (msg) =>
				console.log(msg)
				r = confirm("UNAUTHORIZED")
				if r is true
					@router.navigate('!/start', {trigger: true})
				else
					console.log('try again')

			$(document).ajaxError (event, jqxhr, settings, exception) =>
				if exception is "UNAUTHORIZED"
					@trigger("alert", exception)

			# set authentication stuff now and when user changed
			@setup_tastypie()
			@user.on "change", @setup_tastypie
			console.log("app initialized")

		setup_tastypie: =>
			console.log("setting up tastypie")
			console.debug @user
			user = @user.get("username")
			key  = @user.get("api_key")
			Backbone.Tastypie =
				apiKey:
					username:user,
					key: key
			return
	# this is a singleton class
	# thanks to requirejs we always get the same object when using app = require(app)
	return new App()
