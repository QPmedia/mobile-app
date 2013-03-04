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

			@user = new User({api_key:"foo",username:"mboehme"})
			
			@on "alert", (msg) ->
				alert(msg)
			# set authentication stuff now and when user changed
			@setup_tastypie()
			@user.on "change", @setup_tastypie
			console.log("app initialized")

		setup_tastypie: =>
			console.log("setting up tastypie")
			console.log @user
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
