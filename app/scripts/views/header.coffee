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
			if Backbone.history.fragment is '!/start' or Backbone.history.fragment is ''
				console.log 'open menu here'
			else
				window.history.back()
