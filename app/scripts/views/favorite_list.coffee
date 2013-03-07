define (require) ->
	$              = require("jquery")
	app            = require("app")
	Backbone       = require("backbone")
	Hammer         = require("hammer")
	Favorite           = require("models/favorite")
	FavoriteCollection = require("collections/favorite")
	#require("backbone-fetch-cache")

	class FavoriteListView extends Backbone.View

		initialize: (options) ->
			@template = swig.compile(require("text!templates/favorite_list.html"), { filename: "favorite_list" })
			@favorites = new FavoriteCollection()

			#fires when updating collenction
			@bindTo @favorites, "reset", @modelFetched

		render: ->
			@favorites.fetch()
			#	cache: false
			return this

		modelFetched: ->
			@$el.html @template({favorites : @favorites.toJSON()})
			console.log @favorites

			hammertime = $(".list-view").hammer()

			return this
