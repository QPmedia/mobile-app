define ["backbone"], (Backbone) ->
	class User extends Backbone.Model
		defaults:
			username: localStorage.getItem("username")
			token: localStorage.getItem("token")

		initialize:(options) ->
			@on "change", ->
				localStorage.setItem("username", @get("username"))
				localStorage.setItem("token", @get("token"))
