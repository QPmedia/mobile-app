define (require) ->
	app      = require("app")
	Backbone = require("backbone")

	class Qpon extends Backbone.Model
		urlRoot:->"#{app.API_URL}qpon/"
