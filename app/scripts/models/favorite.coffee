define (require) ->
	#$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")

	class Favorite extends Backbone.Model
		urlRoot:->"#{app.API_URL}qpon/"
