define ["app", "text!templates/settings.html"], (app, template) ->

	class SettingsView extends Backbone.View
		title: 'Settings'
		template : swig.compile(template, { filename: "settings" })
		events:
			'submit form': 'submit'

		submit: (event) ->
			event.preventDefault()
			settings = $(event.target).serializeObject()
			# TODO: make this persistent (localstorage, maybe throug a settings model)
			app.API_URL = settings.api_url if settings.api_url?

		render: ->
			app.header.setTitle(@title)
			@$el.html @template()
			return this
