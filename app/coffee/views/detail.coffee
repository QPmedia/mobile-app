define (require) ->
	$ = require("zepto")
	app = require("app")
	Scaffold = require("scaffold")
	Handlebars = require("handlebars")
	swag = require("swag")

	class Model extends Scaffold.Model
		url: -> 
			"/api/animals/" + @id + ".json"

	class View extends Scaffold.View
		#template: _.template(require('text!templates/detail.jst')),
		#TODO: precompile templates (grunt-contrib-handlebars)
		template: Handlebars.compile(require("text!templates/detail.handlebars"))
		
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
