define (require) ->
	Backbone = require("backbone")

	class User extends Backbone.Model
		defaults:
			username: ""
			api_key: false

		#initialize:(options) ->
		#	@foo = options.api_key

		authenticate: (username,password) ->
			console.log username,password
