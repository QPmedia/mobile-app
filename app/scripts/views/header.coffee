define ["app", "text!templates/header.html"], (app, template) ->
	class HeaderView extends Backbone.View
		template: swig.compile(template, { filename: "header" })

		events:
			'click .js-back-button': 'goback'

		initialize: (options) ->
			@render()

		render: ->
			@$el.html @template({title: @title})
			return this

		setTitle: (title) ->
			@title = title
			$('#title').html title

		goback: ->
			# using bitwise-not "~" is a neat trick.
			# ~-1 == 0 == false
			if (not ~Backbone.history.fragment.indexOf "!/") or Backbone.history.fragment is '!/start'
				app.menu.toggle()
			else
				window.history.back()
