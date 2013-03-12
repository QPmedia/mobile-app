define (require) ->
	$              = require("jquery")
	app            = require("app")
	Backbone       = require("backbone")
	QponCollection = require("collections/qpon")
	
	class QponListView extends Backbone.View

		template : swig.compile(require("text!templates/qpon_list.html"), { filename: "qpon_list" })

		#template : swig.compile(require("text!templates/qpon_list.html"), { filename: "qpon_list" })
		title: 'List'

		initialize: (options) ->
			@qpons = new QponCollection()

			#fires when updating collenction
			@bindTo @qpons, "reset", @modelFetched

		render: ->
			app.header.setTitle(@title)
			@qpons.fetch
				cache: false
			return this

		modelFetched: ->
			@$el.html @template({qpons : @qpons.toJSON()})
			return this
