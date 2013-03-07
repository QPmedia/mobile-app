define (require) ->
	app      = require("app")
	Backbone = require("backbone")
	Favorite     = require("models/favorite")

	class FavoriteCollection extends Backbone.Collection
		initialize: ->
			@model = Favorite
			@urlRoot = app.API_URL+"favorite/"
