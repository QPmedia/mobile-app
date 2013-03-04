define ["backbone"], (Backbone) ->
	class User extends Backbone.Model
		defaults:
			username: ""
			api_key: false

		initialize:(options) ->
			# avoid circular dependency on app
			@API_URL = options.API_URL

		authenticate: (username,password) ->
			console.log username,password
