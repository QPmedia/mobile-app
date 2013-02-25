define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Handlebars = require("handlebars")
	swag = require("swag")
	Qpon = require("models/qpon")

	class QponDetailView extends Backbone.View

		template: Handlebars.compile(require("text!templates/qpon_detail.html"))

		initialize: (options) ->
			@model = new Qpon(id: options.id)

			#app.trigger('headerbar:update', {
			#        title: 'Weapon selected...'
			#      });
			@bindTo @model, "change", @modelFetched

		render: ->
			@model.fetch()
			return this

		modelFetched: ->
			@$el.html @template({data: @model.toJSON()})
			#app.trigger "headerbar:update",
			#title: @model.get("name")

			return this