define ["app", "text!templates/start.html"], (app, template) ->

	class StartView extends Backbone.View
		title: 'Start'
		template : swig.compile(template, { filename: "start" })
		events:
			'click #scan': 'scan'

		scan: (event) ->
			event.preventDefault()
			console.log('scanning');
			console.log window.plugins
			#console.log window.plugins.barcodeScanner
			try
				scanner = window.PhoneGap.require("cordova/plugins/barcodescanner")
				console.log "SCANNER:!!", scanner
				scanner.scan (args) ->
					console.log """
								Scanner result:
									text: #{args.text}
									format: #{args.format}
									cancelled: #{args.cancelled}
								"""
					app.router.navigate("!/coupons/#{args.text}", {trigger:true})
			catch ex
				console.log(ex);

		render: ->
			app.header.setTitle(@title)
			@$el.html @template()
			return this
