define ["app", "text!templates/start.html"], (app, template) ->

	class StartView extends Backbone.View
		title: 'Start'
		template : swig.compile(template, { filename: "start" })
		events:
			'click #scan': 'scan'

		scan: ->
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
				console.log(ex.message);

		render: ->
			app.header.setTitle(@title)
			@$el.html @template()
			return this
