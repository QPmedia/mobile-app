define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Handlebars = require("handlebars")
	swag = require("swag")

	class Model extends Backbone.Model
		url: -> 
			"/api/animals/" + @id + ".json"

	class View extends Backbone.View
		#template: _.template(require('text!templates/detail.jst')),
		#TODO: precompile templates (grunt-contrib-handlebars)
		template: Handlebars.compile(require("text!templates/detail.html"))
		
		# Respond to UI events, calling named functions in this object.
		# These events will automatically be cleaned up when the view is hidden.
		# Example:
		# "click .check"              : "toggleDone",
		# "dblclick div.todo-text"    : "edit"
		events: {}

		initialize: (options) ->
			@model = new Model(id: options.id)

			#app.trigger('headerbar:update', {
			#        title: 'Weapon selected...'
			#      });
			@bindTo @model, "change", @modelFetched

		render: ->
			@model.fetch()
			return this

		modelFetched: ->
			@$el.html @template(@model.toJSON())
			app.trigger "headerbar:update",
			title: @model.get("name")

			return this
