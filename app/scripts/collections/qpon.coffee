define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Qpon = require("models/qpon")

	class QponCollection extends Backbone.Collection
		initialize: ->
			@model = Qpon
			@url   = "#{app.API_URL}qpon/?format=jsonp&callback=?&username=mboehme&api_key=foo"

		parse: (response) ->
			response.objects