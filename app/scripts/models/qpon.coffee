define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Handlebars = require("handlebars")
	swag = require("swag")

	class Qpon extends Backbone.Model
		url: -> 
			"/api/favoriteqpon/" + @id + ".json"