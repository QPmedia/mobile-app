define (require) ->
	$        = require("jquery")
	app      = require("app")
	Backbone = require("backbone")
	Qpon     = require("models/qpon")
	Favorite = require("models/favorite")

	class QponDetailView extends Backbone.View
		title: 'Detail'
		
		events:
			'click .js-add-favorite': 'add_favorite' 

		initialize: (options) ->
			@model = new Qpon(id: options.id)
			@template = swig.compile(require("text!templates/qpon_detail.html"), { filename: "qpon_detail" })
			@bindTo @model, "change", @model_fetched
			console.log(app)

		add_favorite: (ev) ->
			console.log ev
			qpon_id = $(ev.currentTarget).data("id")
			qpon_uri = $(ev.currentTarget).data("uri")
			console.log qpon_uri
			fav = new Favorite({qpon:qpon_id,user:1})
			fav.save()
			console.log fav
		render: ->
			app.header.setTitle(@title)
			@model.fetch()
			return this

		model_fetched: ->
			@$el.html @template({qpon: @model.toJSON()})
			return this
