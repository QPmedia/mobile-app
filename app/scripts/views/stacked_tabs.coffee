define (require) ->
	$              = require("jquery")
	app            = require("app")
	Backbone       = require("backbone")
	
	class StackedTabsView extends Backbone.View

		stackedTabs : swig.compile(require("text!templates/_stacked_tabs.html"), { filename: "stacked_tabs" })
		
		el: '#tabs'

		initialize: (options) ->
			#FixMe
			$('#main').css('top', 96) 

			console.log @options.items
			
		render: ->
			#why is only 'append' working here?
			@$el.append @stackedTabs({items:@options.items})
			return this

		#remove UI Elements here - 'onDestroy' 
		remove: ->
			#FixMe
			$('#main').css('top', 48) 
			
			@$el.html ''