define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Handlebars = require("handlebars")
	swag = require("swag")
	Qpon = require("models/qpon")
	QponCollection = require("collections/qpons")

	class QponListView extends Backbone.View

		template: Handlebars.compile(require("text!templates/qpon_list.html"))
		
		initialize: (options) ->
			#@qpon = new Qpon()

			@qpons = new QponCollection()


			#app.trigger('headerbar:update', {
			#        title: 'Weapon selected...'
			#      });
			#@bindTo @qpon, "change", @modelFetched

			#fires when updating collenction
			@bindTo @qpons, "reset", @modelFetched

		render: ->
			#@qpon.fetch()
			@qpons.fetch success: (data) ->
				console.log data.toJSON()
			return this

		modelFetched: ->
			@$el.html @template({data : @qpons.toJSON()})

			#app.trigger "headerbar:update",
			#title: @qpon.get("headline")
			return this