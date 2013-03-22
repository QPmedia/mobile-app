define (require) ->
	$              = require("jquery")
	app            = require("app")
	Backbone       = require("backbone")
	QponCollection = require("collections/qpon")
	StackedTabs    = require("views/stacked_tabs")
	
	class QponListView extends Backbone.View

		template : swig.compile(require("text!templates/qpon_list.html"), { filename: "qpon_list" })
		
		title: 'List'

		initialize: (options) ->
			@qpons = new QponCollection()

			#Stacked Tabs
			@items = {
				'Neu':'#',
				'Angesagt':'#',
				'Entfernung':'#',
			}
			@tabs = new StackedTabs({items : @items})
			@tabs.render()

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

		#remove UI Elements here - 'onDestroy' 
		remove: ->
			@tabs.remove()
