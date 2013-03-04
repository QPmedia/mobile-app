define (require) ->
	app      = require("app")
	Backbone = require("backbone")
	Qpon     = require("models/qpon")

	class QponCollection extends Backbone.Collection
		initialize: ->
			@model = Qpon
			@urlRoot = app.API_URL+"qpon/"
