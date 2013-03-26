define ["app", "text!templates/notification.html"], (app, template) ->

	class NotificationView extends Backbone.View

		template : swig.compile(template, { filename: "notification" })

		title : "Title"
		msg : "Msg"

		initialize:(options) ->
			@title = @options.title if @options.title?
			@msg = @options.msg if @options.msg?
				
			@render()


		render: ->
			@$el.html @template({title:@title, msg:@msg})
			return this
