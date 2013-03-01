define (require) ->
	$ = require("zepto")
	app = require("app")
	Backbone = require("backbone")
	require("backbone-tastypie")
	Qpon = require("models/qpon")

	class QponCollection extends Backbone.Collection
		initialize: ->
			@model = Qpon
			@urlRoot = app.API_URL+"qpon/"
			#@url   = "#{app.API_URL}qpon/?format=jsonp&username=mboehme&api_key=sadghshrcallback=?"
