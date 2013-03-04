define (require) ->
	$ = require("jquery")
	app = require("app")
	Backbone = require("backbone")
	require("backbone-zombienation")

	class FooterView extends Backbone.View
		el: $('#footer')


		
		initialize: (options) ->
			@template = swig.compile(require("text!templates/footer.html"), { filename: "footer" })
			@message = 'mymsg'

			app.registerModule("footer", {
        		'update': @show_msg
      		});

			@render()

		render: ->
			@$el.html @template({message: @message})
			return this

		show_msg: (msg) ->
			@message = msg
			@render()