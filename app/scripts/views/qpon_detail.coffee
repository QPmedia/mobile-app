define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Qpon = require("models/qpon")
	require("backbone-zombienation")

	class QponDetailView extends Backbone.View
		
		initialize: (options) ->
			@model = new Qpon(id: options.id)
			@template = swig.compile(require("text!templates/qpon_detail.html"), { filename: "qpon_detail" })
			#app.trigger('headerbar:update', {
			#        title: 'Weapon selected...'
			#      });
			@bindTo @model, "change", @modelFetched

		render: ->
			@model.fetch()
			return this

		modelFetched: ->
			@$el.html @template({data: @model.toJSON()})
			app.trigger "view:update", {}
			#app.trigger "headerbar:update",
			#title: @model.get("name")

			return this