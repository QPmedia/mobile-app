define (require) ->
	#$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	require("backbone-tastypie")

	class Qpon extends Backbone.Model
		urlRoot:->app.API_URL+"qpon/"
