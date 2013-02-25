define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Handlebars = require("handlebars")
	swag = require("swag")
	qponModel = require("qponModel")

	class Model extends Backbone.Model
		url: -> 
			"/api/animals/" + '1' + ".json"

	class qponListView extends Backbone.View
		#template: _.template(require('text!templates/detail.jst')),
		#TODO: precompile templates (grunt-contrib-handlebars)
		template: Handlebars.compile(require("text!templates/qponList.html"))
		
		# Respond to UI events, calling named functions in this object.
		# These events will automatically be cleaned up when the view is hidden.
		# Example:
		# "click .check"              : "toggleDone",
		# "dblclick div.todo-text"    : "edit"
		events: {}

		initialize: (options) ->
			@model = new Model()

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