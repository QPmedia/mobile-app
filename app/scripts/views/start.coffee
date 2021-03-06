define ["app", "text!templates/start.html", "views/notification"], (app, template, Notification) ->

	class StartView extends Backbone.View
		title: 'Start'
		template : swig.compile(template, { filename: "start" })
		events:
			'click #scan': 'scan'
			'click #notify-page': 'notifyPage'
			'click #notify-pop': 'notifyPop'

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

		notifyPage: ->
			foo = new Notification({type:'page', title:'mytitle', msg:'foo'})
			@$el.html foo.el

		notifyPop: ->
			foo = new Notification({type:'pop', title:'mytitle', msg:'foo'})
			@$el.prepend foo.el