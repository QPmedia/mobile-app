define (require) ->
	$              = require("jquery")
	app            = require("app")
	Backbone       = require("backbone")
	QponCollection = require("collections/qpon")
	require("waypoints")

	class LazyListView extends Backbone.View

		template : swig.compile(require("text!templates/lazy_list.html"), { filename: "lazy_list" })
		item_template : swig.compile(require("text!templates/lazy_item.html"), { filename: "lazy_item" })

		title: 'Lazy List'

		initialize: (options) ->
			@qpons = new QponCollection()

			#fires when updating collenction
			@bindTo @qpons, "reset", @collectionFetched

		render: ->
			app.header.setTitle(@title)
			@qpons.fetch
				cache: false

			#render empty ul
			@$el.html @template()
			return this

		collectionFetched: ->
			@current_item = 0

			#append default items
			$('.lazy-list').append @item_template({qpons : @qpons.toJSON().slice(0,6)})
			@setWaypoits()

			return this

		setWaypoits: ->
			$(".waypoint").waypoint ((direction)=>
				if direction is 'down'
					console.log @qpons.toJSON()[@current_item]
					@appendItem()
			),
				context: '#main'


		appendItem: ->
			$('.lazy-list').append @item_template({qpons : @qpons.toJSON().slice(@current_item, @current_item + 1)})
			@current_item++
			