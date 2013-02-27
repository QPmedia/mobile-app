define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Hammer = require("hammer")
	Qpon = require("models/qpon")
	QponCollection = require("collections/qpon")
	require("backbone-zombienation")

	class QponListView extends Backbone.View
		template : swig.compile(require("text!templates/qpon_list.html"), { filename: "qpon_list" })

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
			@qpons.fetch()
			return this

		modelFetched: ->
			@$el.html @template({qpons : @qpons.toJSON()})

			hammertime = $(".list-view").hammer()
			hammertime.on "tap", "> li", (e) ->
				$(this).addClass "selected"
			#hammertime.on "release", "> li", (e) ->
				#$(this).removeClass "selected"
			hammertime.on "dragstart", ->
				$(this).find("li").removeClass "selected"

			app.trigger "view:update", {}
			#title: @qpon.get("headline")

			return this
