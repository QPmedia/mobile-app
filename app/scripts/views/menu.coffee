define ["app", "hammer", "text!templates/menu.html"]
, (app, Hammer, template) ->
	class Menu extends Backbone.View
		template: swig.compile(template, { filename: "menu" })
		options:
			width: null

		position:     0
		translate_to: 0

		initialize: (options) ->
			hammertime = Hammer("#main, #menu").on "drag dragend dragstart", (ev) =>
				@handleHammer ev

			@options.width = @$el.width() unless options.width?
			@render()

		render: ->
			@$el.html @template()
			return this

		handleHammer: (ev) ->
			# FIXME: in qpon_list, start dragging right and then bot.
			# menu will be left half open
			#console.log ev
			#return unless ev.gesture.direction in ["right", "left"]
			#ev.preventDefault()
			#console.log ev.type
			#console.log ev.gesture.velocityX
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
					threshold = @options.width*0.5
					$(container).css("-webkit-transition", "-webkit-transform 0.2s")
					
					#go fast if user went fast as well
					if ev.gesture and ev.gesture.velocityX > 1.2
						$(container).css("-webkit-transition", "-webkit-transform 0.01s")
						if ev.gesture.direction is "right"
							threshold = -1#200*0.15

						else
							threshold = @options.width

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
						@translate_to = @options.width
					else
						@translate_to = 0

					$(container).css('-webkit-transform', 'translate3d(' + @translate_to + 'px,0,0) scale3d(1,1,1)')
					@position = @translate_to

				when "drag"
					if not ev.gesture or ev.gesture.direction not in ["left","right"]
						return
					#console.log ev
					# 0<pos<200
					# youtube uses 1:1 drag -> move...
					dx = ev.gesture.deltaX #* 0.4
					@translate_to = Math.min(Math.max(0, @position + dx), @options.width)
					#console.log @translate_to
					$(container).css('-webkit-transform', 'translate3d(' + @translate_to + 'px,0,0) scale3d(1,1,1)')
					#ev.preventDefault()