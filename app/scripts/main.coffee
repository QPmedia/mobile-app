define (require) ->
	# Libs
	$ = require("zepto")
	require("swig")
	swig.init
		allowErrors: false
		autoescape: true
		cache: true
		encoding: 'utf8'
		filters: require("utils/filter")
		root: "/"
		tags:  {}
		extensions: {}
		tzOffset: 0
		
	require("utils/remotedata")
	require("backbone-tastypie")
	FooterView = require("views/footer")
	

	User = require("models/user")
	# App-specific
	app = require("app")
	Router = require("router")

	# Treat the jQuery ready function as the entry point to the application.
	# Inside this function, kick-off all initialization, everything up to this
	# point should be definitions.
	$ ->
		# Cache the DOM elements for later use
		$el =
			app: $("#app")
			headerbar: $("#headerbar")
			footerbar: $("#footerbar")
			content: $("#content")

		app.router = new Router(container: $("#content"))
		app.user = new User({api_key:"qpmedia",username:"t.boehme@qpmedia.de"})
		
		Backbone.Tastypie = 
			apiKey:
				username: app.user.get("username"),
				key: app.user.get("api_key")
		app.API_URL = "http://192.168.2.12:8000/m/api/v1/"

		#new Hammer($el.app[0])

		app.registerModule("view", {
        	'update': scroll.refresh
      	}, scroll);

		# Uncomment to test components
		# require('modules/devicetests');

		# Trigger the initial route
		# At this point, all dependencies required above will be loaded
		# This means all event modules will be registered and ready to be triggered
		Backbone.history.start()
		footer = new FooterView()


	# All navigation that is relative should be passed through the navigate
	# method, to be processed by the router.  If the link has a data-bypass
	# attribute, bypass the delegation completely.
	$(document).on "click", "a[href]:not([data-bypass])", (evt) ->
		
		app.trigger "footer:update"
		# Get the absolute anchor href.
		href =
			prop: $(this).prop("href")
			attr: $(this).attr("href")

		# Get the absolute root.
		root = location.protocol + "//" + location.host + app.root

		# Ensure the root is part of the anchor href, meaning it's relative.
		if href.prop.slice(0, root.length) is root
			# Stop the default event to ensure the link will not cause a page refresh.
			evt.preventDefault()

			# `Backbone.history.navigate` is sufficient for all Routers and will
			# trigger the correct events. The Router's internal `navigate` method
			# calls this anyways. The fragment is sliced from the root.
			Backbone.history.navigate href.attr, true

	return
