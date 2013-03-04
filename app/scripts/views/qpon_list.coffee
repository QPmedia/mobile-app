define (require) ->
	$              = require("jquery")
	app            = require("app")
	Backbone       = require("backbone")
	Hammer         = require("hammer")
	Qpon           = require("models/qpon")
	QponCollection = require("collections/qpon")
	require("backbone-fetch-cache")

	class QponListView extends Backbone.View
		#template : swig.compile(require("text!templates/qpon_list.html"), { filename: "qpon_list" })

		initialize: (options) ->
			@template = swig.compile(require("text!templates/qpon_list.html"), { filename: "qpon_list" })
			@qpons = new QponCollection()

			#app.trigger('headerbar:update', {
			#        title: 'Weapon selected...'
			#      });
			#@bindTo @qpon, "change", @modelFetched

			#fires when updating collenction
			@bindTo @qpons, "reset", @modelFetched

		render: ->
			@qpons.fetch
				cache: true
			return this

		modelFetched: ->
			@$el.html @template({qpons : @qpons.toJSON()})

			hammertime = $(".list-view").hammer()

			#title: @qpon.get("headline")

			return this
