define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Handlebars = require("handlebars")
	swag = require("swag")
	Qpon = require("models/qpon")

	class QponListView extends Backbone.View
		#template: _.template(require('text!templates/detail.jst')),
		#TODO: precompile templates (grunt-contrib-handlebars)
		template: Handlebars.compile(require("text!templates/qpon_list.html"))
		
		# Respond to UI events, calling named functions in this object.
		# These events will automatically be cleaned up when the view is hidden.
		# Example:
		# "click .check"              : "toggleDone",
		# "dblclick div.todo-text"    : "edit"
		events: {}

		initialize: (options) ->
			@qpon = new Qpon()

			#app.trigger('headerbar:update', {
			#        title: 'Weapon selected...'
			#      });
			@bindTo @qpon, "change", @modelFetched

		render: ->
			@qpon.fetch()
			return this

		modelFetched: ->
			@$el.html @template(@qpon.toJSON())
			app.trigger "headerbar:update",
			title: @qpon.get("headline")

			return this