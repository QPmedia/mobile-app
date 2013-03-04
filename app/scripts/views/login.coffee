define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	Qpon = require("models/qpon")
	require("backbone-zombienation")

	class LoginView extends Backbone.View
		template : swig.compile(require("text!templates/login.html"), { filename: "login" })

		events:
        'click #login' : 'login'

		initialize: (options) ->
			
			@render

		render: ->
			@$el.html @template()
			app.trigger "view:update", {}
			return this

		login: ->
			alert 'foo'