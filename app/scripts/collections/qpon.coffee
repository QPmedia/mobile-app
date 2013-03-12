define (require) ->
	app      = require("app")
	Backbone = require("backbone")
	Qpon     = require("models/qpon")

	class QponCollection extends Backbone.Collection
		initialize: ->
			@model = Qpon
			@url   = "#{app.API_URL}qpon/"

		parse: (data) ->
			return data.results
