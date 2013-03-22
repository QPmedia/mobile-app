define (require) ->
	app                = require ("app")
	Hammer             = require("hammer")
	#Hammer           = require("hammer-jquery")
	CategoryCollection = require("collections/category")

	class Menu extends Backbone.View
		template: swig.compile(require("text!templates/menu.html"), { filename: "menu" })
		categories_template: swig.compile(require("text!templates/_categories.html"), { filename: "categories_template" })

		options:
			width: null

		position:     0
		translate_to: 0
		events:
			'click #scan': 'scan'

		initialize: (options) ->

			@categories = new CategoryCollection()

			#fires when updating collenction
			@bindTo @categories, "reset", @update_categories

			@categories.fetch
				cache: false

			# jquery-plugin adds noticable overhead and we don't really need it here
			main_el = document.getElementById("main")
			menu_el = document.getElementById("menu")
			hammer_opts =
				drag_block_horizontal : false
				drag_block_vertical   : false
				drag_lock_to_axis     :false
			hammertime = Hammer(menu_el, hammer_opts).on "drag dragend dragstart",
				(ev) =>	@handleHammer ev
			hammertime2 = Hammer(main_el, hammer_opts).on "drag dragend dragstart",
				(ev) =>	@handleHammer ev

			@options.width = @$el.width() unless options.width?
			@render()

		render: ->
			@$el.html @template()
			return this

		update_categories: ->
			$('ul#categories').html(@categories_template({categories : @categories.toJSON()}))
			console.log @categories





		animate: (pos) ->
			$(@options.container).css('-webkit-transform', "translate3d(#{pos}px,0,0) scale3d(1,1,1)")
		set_speed: (seconds) ->
			$(@options.container).css("-webkit-transition", "-webkit-transform #{seconds}s")
		show: ->
			@position = @options.width
			@animate @options.width
		hide: ->
			@position = 0
			@animate 0

		toggle: ->
			if @position is 0
				@show()
			else
				@hide()

		scan: (event) ->
			event.preventDefault()
			console.log('scanning');

			try
				window.plugins.barcodeScanner.scan (args) ->
					console.log """
								Scanner result:
									text: #{args.text}
									format: #{args.format}
									cancelled: #{args.cancelled}
								"""
					app.router.navigate("!/coupons/#{args.text}", {trigger:true})
			catch ex
				console.log(ex.message)

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
					@set_speed(0)

				when "dragend"
					threshold = @options.width*0.5
					@set_speed(0.2)

					#go fast if user went fast as well
					if ev.gesture and ev.gesture.velocityX > 1.2
						@set_speed(0.01)
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

					@animate(@translate_to)

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
					@animate(@translate_to)
					#ev.preventDefault()
