define (require) ->
	$        = require("jquery")
	app      = require("app")
	Backbone = require("backbone")
	Qpon     = require("models/qpon")
	Favorite = require("models/favorite")
	Actionbar = require("views/footer")

	class QponDetailView extends Backbone.View
		title: 'Detail'

		events:
			'click .js-add-favorite': 'add_favorite'

		initialize: (options) ->
			@actionbar = new Actionbar()

			@model = new Qpon(id: options.id)
			@template = swig.compile(require("text!templates/qpon_detail.html"), { filename: "qpon_detail" })
			@bindTo @model, "change", @model_fetched

			console.log(app)

		update_distance: (loc) ->
			$(".js-add-favorite").append("<p>dist/loc: #{@model.distance()} #{loc.coords.latitude},#{loc.coords.longitude}</p>")
			#alert(loc)
		add_favorite: (ev) ->
			console.log ev
			qpon_id = $(ev.currentTarget).data("id")
			qpon_uri = $(ev.currentTarget).data("uri")
			console.log qpon_uri
			fav = new Favorite({qpon_id:qpon_id})
			fav.save()
			app.router.navigate("!/favorites", {trigger: true});
		render: ->
			app.header.setTitle(@title)
			@model.fetch()
			return this

		model_fetched: ->
			@bindTo app, "location_changed", @update_distance
			@$el.html @template({qpon: @model.toJSON(), distance:@model.distance()})
			return this

		#remove UI Elements here - 'onDestroy'
		remove: ->
			@actionbar.remove()
