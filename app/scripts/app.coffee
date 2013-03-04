define (require) ->
	User = require("models/user")

	# initialize swig, add our custom filters
	swig = require("swig")
	swig.init
		filters: require("utils/filter")

	class App
		API_URL: "http://192.168.2.12:8000/m/api/v1/"

		constructor: ->
			@user = new User({api_key:"foo",username:"mboehme"})
			

			# set authentication stuff now and when user changed
			@setup_tastypie()
			@user.on "change", @setup_tastypie
			console.log("app initialized")

		setup_tastypie: ->
			console.log("setting up tastypie")
			console.log @user
			Backbone.Tastypie=
				apiKey:
					username: @user.get("username"),
					key: @user.get("api_key")
			return
	# this is a singleton class
	# thanks to requirejs we always get the same object when using app = require(app)
	return new App()
