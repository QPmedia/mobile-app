define (require) ->
	$        = require("jquery")
	app      = require("app")
	Backbone = require("backbone")
	require("backbone-zombienation")

	class HeaderView extends Backbone.View
		el: $('#header')

		events:
			'click #backbutton': 'goback'
		

		initialize: (options) ->
			#default Title
			@title = 'Startpage'

			@template = swig.compile(require("text!templates/header.html"), { filename: "header" })

			@render()

		render: ->
			@$el.html @template({title: @title})
			return this

		setTitle: (title) ->
			@title = title
			$('#title').html title

		#setMenu

		goback: ->
			if Backbone.history.fragment is '!/start'
				alert 'open menu here'
				#translate_to = 200
				#$('#app').css('-webkit-transform', 'translate3d(' + translate_to + 'px,0,0) scale3d(1,1,1)')
			else
				window.history.back()

