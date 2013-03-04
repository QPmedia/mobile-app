define (require) ->
	$ = require("jquery")
	app = require("app")
	Backbone = require("backbone")
	Qpon = require("models/qpon")
	require("backbone-zombienation")

	class QponDetailView extends Backbone.View
		swig.compile(require("text!templates/login.html"), { filename: "login" })

		template : swig.compile(require("text!templates/start.html"), { filename: "start" })

		initialize: (options) ->

			@render

		render: ->
			@$el.html @template()
			return this