define ["backbone", "jquery"], (Backbone, $) ->
	class User extends Backbone.Model
		defaults:
			username: localStorage.getItem("username")
			api_key: localStorage.getItem("api_key")

		initialize:(options) ->
			# avoid circular dependency on app
			@API_URL = options.API_URL

			@on "change", ->
				localStorage.setItem("username",@get("username"))
				localStorage.setItem("api_key",@get("api_key"))
				
		authenticate: (username, password) =>
			console.log username,password
			url = @API_URL + "user/login/?format=json&username=#{username}&password=#{password}"
			$.ajax
				type: "GET"
				url: url
				#dataType: options.dataType or "text"
				#timeout: options.timeout
				#headers: options.headers
				async: false
				#global: options.global or true
				#context: options.context
				success: (data, status, xhr) =>
					@set("username", username)
					@set("api_key", data.api_key)

				error: (xhr) ->
					console.log("login_error:" + xhr)
