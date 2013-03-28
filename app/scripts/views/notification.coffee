define ["app", "text!templates/notification.html"], (app, template) ->

	class NotificationView extends Backbone.View

		template : swig.compile(template, { filename: "notification" })

		type : 'pop'
		title : "Title"
		msg : "Msg"

		initialize:(options) ->
			@type = @options.type if @options.type?
			@title = @options.title if @options.title?
			@msg = @options.msg if @options.msg?
				
			@render()


		render: ->
			#TODO use foundation reveal here
			@$el.html @template({type: @type, title:@title, msg:@msg})
			return this
