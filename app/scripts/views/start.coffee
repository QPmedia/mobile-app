define (require) ->
	$ = require("jquery")
	app = require("app")
	Backbone = require("backbone")
	Qpon = require("models/qpon")
	Hammer = require("hammer")
	require("backbone-zombienation")
	

	class StartView extends Backbone.View
		#swig.compile(require("text!templates/login.html"), { filename: "login" })

		template : swig.compile(require("text!templates/start.html"), { filename: "start" })
		events:
			'click #scan': 'scan' 

		position : 0

		initialize: (options) ->
			self = this
			hammertime = Hammer("#wrapper", {prevent_default: false}).on("dragleft dragright dragend", (ev) ->
				self.handleHammer ev
			)

			@position = 0
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

		handleHammer: (ev) ->

			self = this
			
			dx = ev.gesture.deltaX * 0.3
			switch ev.type

				when "dragend"
					if dx >= 50
						self.updateSlide 200
						@position = 200

					else if dx <= 50
						self.updateSlide 0
						@position = 0



				when "dragright"
					if dx <= 200
						@position = dx
					else
						@position = 200

					@position = Math.min(dx, 200)
					console.log @position
					self.updateSlide(@position)

				when "dragleft"
					console.log('start-left-pos: ' + @position)
					@position = 200 + dx
					
					@position = Math.max(0, @position)
					console.log @position
					self.updateSlide(@position)
			return
					

		updateSlide: (width) ->
			$('#wrapper').css('-webkit-transform', 'translate3d(' + width + 'px,0,0) scale3d(1,1,1)')
			#$('#wrapper').css('left', width)
