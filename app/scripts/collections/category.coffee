define (require) ->
	app      = require("app")
	Backbone = require("backbone")

	class CategoryCollection extends Backbone.Collection
		initialize: ->
			@url   = "#{app.API_URL}category/"

		parse: (data) ->	
			if data.results
				return data.results
			else
				return data