define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Qpon = require("models/qpon")
	QponCollection = require("collections/qpon")
	require("backbone-zombienation")

	class QponListView extends Backbone.View

		template : swig.compile(require("text!templates/qpon_list.html"), { filename: "qpon_list" })
		
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
			@qpons.fetch()
			return this

		modelFetched: ->
			@$el.html @template({qpons : @qpons.toJSON()})

			#app.trigger "headerbar:update",
			#title: @qpon.get("headline")
			return this