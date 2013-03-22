define (require) ->
	$        = require("jquery")
	app      = require("app")
	Backbone = require("backbone")
	require("backbone-zombienation")

	class FooterView extends Backbone.View
		el: $('#actionbar')

		initialize: (options) ->
			#FixMe
			$('#main').css('bottom', 48) 

			@template = swig.compile(require("text!templates/footer.html"), { filename: "footer" })

			@render()

		render: ->
			@$el.html @template
			return this

		#remove UI Elements here - 'onDestroy' 
		remove: ->
			#FixMe
			$('#main').css('bottom', 0) 
			
			@$el.html ''