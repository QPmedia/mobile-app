define (require) ->
	#$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")

	class Qpon extends Backbone.Model
		url: ->
			"#{app.API_URL}qpon/#{@id}/?format=jsonp&callback=?"