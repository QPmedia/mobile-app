define (require) ->
	$ = require("jquery")
	app = require("app")
	Backbone = require("backbone")
	Qpon = require("models/qpon")
	require("backbone-zombienation")

	class StartView extends Backbone.View
		#swig.compile(require("text!templates/login.html"), { filename: "login" })

		template : swig.compile(require("text!templates/start.html"), { filename: "start" })
		events:
			'click #scan': 'scan' 

		initialize: (options) ->
			@render

		scan: ->
			console.log('scanning');

			try
				window.plugins.barcodeScanner.scan (args) ->
					console.log("Scanner result: \n" +
						"text: " + args.text + "\n" +
						"format: " + args.format + "\n" +
						"cancelled: " + args.cancelled + "\n");
					#document.getElementById("info").innerHTML = args.text;
					#alert args.text
					app.router.navigate("!/coupons/#{args.text}", {trigger:true})
					console.log(args);
			catch ex
				console.log(ex.message);

		render: ->
			@$el.html @template()
			return this