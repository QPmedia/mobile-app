define ["collections/favorite", "text!templates/favorite_list.html"]
,(FavoriteCollection, template) ->
	class FavoriteListView extends Backbone.View
		template: swig.compile(template, { filename: "favorite_list" })

		initialize: (options) ->
			@favorites = new FavoriteCollection()
			#fires when updating collenction
			@bindTo @favorites, "reset", @modelFetched

		render: ->
			@favorites.fetch()
			#	cache: false
			return this

		modelFetched: ->
			@$el.html @template({objects : @favorites.toJSON()})
			console.log @favorites

			return this
