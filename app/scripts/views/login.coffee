define (require) ->
	$        = require("jquery")
	app      = require("app")
	Backbone = require("backbone")
	Qpon     = require("models/qpon")

	class LoginView extends Backbone.View
		template : swig.compile(require("text!templates/login.html"), { filename: "login" })


		events:
			'submit form#loginform': 'login' 

		initialize: (options) ->
			@render

		render: =>
			@$el.append @template({user:app.user.toJSON()})
			return this

		login: ->
			username = @$('#username').val()
			pw = @$('#password').val()
			console.log(username)
			# make auth accept a callback with status etc.
			app.user.authenticate username, pw
