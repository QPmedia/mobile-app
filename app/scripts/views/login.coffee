define (require) ->
	$        = require("jquery")
	app      = require("app")
	Backbone = require("backbone")
	Qpon     = require("models/qpon")

	class LoginView extends Backbone.View
		template : swig.compile(require("text!templates/login.html"), { filename: "login" })


		events:
        'click #login' : 'login'

		initialize: (options) ->
			
			@render

		render: ->
			@$el.html @template()
			return this

		login: ->
			alert @$('#username').val()
			alert @$('#password').val()
			
			#userAuth here
