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
			@qpon = new Qpon()

			@qpons = new QponCollection()


			#app.trigger('headerbar:update', {
			#        title: 'Weapon selected...'
			#      });
			console.log 'bind'
			#@bindTo @qpon, "change", @modelFetched

			#fires when updating collenction
			@bindTo @qpons, "reset", @modelFetched

		render: ->
			#@qpon.fetch()
			console.log 'render'
			@qpons.fetch success: (data) ->
				console.log data.toJSON()
			return this

		modelFetched: ->
			console.log 'changed'
			@$el.html @template({data : @qpons.toJSON()})
			console.log 'objects: ' + @qpons

			app.trigger "headerbar:update",
			title: @qpon.get("headline")

			return this