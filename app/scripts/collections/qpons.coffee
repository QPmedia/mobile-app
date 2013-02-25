define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Handlebars = require("handlebars")
	swag = require("swag")
	Qpon = require("models/qpon")

	class QponCollection extends Backbone.Collection
		initialize: ->
			@model = Qpon
			@url   = '/api/favoriteqpon.json'

		parse: (response) ->
			response.objects