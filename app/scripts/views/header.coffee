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
			#toDo: refactoring
			position = new WebKitCSSMatrix(window.getComputedStyle(document.getElementById("app")).webkitTransform)
			container = '#app'

			if Backbone.history.fragment is '!/start' or Backbone.history.fragment is ''
				if position.m41 > 0
					$(container).css('-webkit-transform', 'translate3d(' + 0 + 'px,0,0) scale3d(1,1,1)')
				else
					$(container).css('-webkit-transform', 'translate3d(' + 200 + 'px,0,0) scale3d(1,1,1)')
			else
				window.history.back()
