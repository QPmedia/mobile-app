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
			hammertime = Hammer("#main",).on "swipe drag dragend dragstart", (ev) =>
				@handleHammer ev
			

			@position = 0
			@max_pos = 150
			@swiping = false
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
			# FIXME: in qpon_list, start dragging right and then bot.
			# menu will be left half open
			return unless ev.gesture.direction in ["right", "left"]
			console.log ev.type
			console.log ev.gesture.velocityX
			# too bad the swipe event if fired after all drag events...
			# kind of useless, maybe a second Hammer instance...
			# if ev.type is "swipe"
			# 	console.log ev.gesture.direction
			# 	if ev.gesture.direction is "right"
			# 		@translate_to = 200
			# 	else
			# 		@translate_to = 0
			# 	@swiping = true
			# 	#return
			container = '#app'

			switch ev.type
				when "dragstart"
					$(container).css("-webkit-transition", "-webkit-transform 0s")

				when "dragend"
					threshold = @max_pos*0.5
					$(container).css("-webkit-transition", "-webkit-transform 0.8s")
					
					#go fast if user went fast as well
					if ev.gesture.velocityX > 1.2
						$(container).css("-webkit-transition", "-webkit-transform 0.01s")
						if ev.gesture.direction is "right"
							threshold = -1#200*0.15

						else
							threshold = @max_pos

					@position = @translate_to
					# snap at 60%
					# threshold = 200*0.6
					# if ev.gesture.direction is "right"
					# 	if @position > threshold
					# 		@translate_to = 200
					# 	else
					# 		@translate_to = 0
					# else if ev.gesture.direction is "left"
					# 	if @position <= threshold
					# 		@translate_to = 200
					# 	else
					# 		@translate_to = 0
					# else
					# 	alert "dafuq!, neither 'left' nor 'right'"
					
					if @position > threshold
						@translate_to = @max_pos
					else
						@translate_to = 0

					$(container).css('-webkit-transform', 'translate3d(' + @translate_to + 'px,0,0) scale3d(1,1,1)')
					@position = @translate_to

				when "drag"# and not @swiping
					# 0<pos<200
					# youtube uses 1:1 drag -> move...
					dx = ev.gesture.deltaX #* 0.4
					@translate_to = Math.min(Math.max(0, @position + dx), @max_pos)
					$(container).css('-webkit-transform', 'translate3d(' + @translate_to + 'px,0,0) scale3d(1,1,1)')

			return
