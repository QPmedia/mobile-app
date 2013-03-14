define (require) ->
	app      = require("app")
	Backbone = require("backbone")

	class Favorite extends Backbone.Model
		urlRoot:->"#{app.API_URL}favorite/"
		sync:app.sync_with_token
