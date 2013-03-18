define ["collections/favorite", "models/favorite", "text!templates/favorite_list.html"]
,(FavoriteCollection, Favorite, template) ->
	class FavoriteListView extends Backbone.View
		template: swig.compile(template, { filename: "favorite_list" })
		events:
			"click .del": "delete_fav"

		initialize: (options) ->
			@favorites = new FavoriteCollection()
			#fires when updating collenction
			@bindTo @favorites, "reset", @modelFetched
			@bindTo @favorites, "destroy", @modelFetched
		delete_fav:(ev)->
			ev.preventDefault()
			id = $(ev.currentTarget).data("id")
			fav = @favorites.get({id:id})
			fav.destroy({wait: true})
			#@render()
		render: ->
			@favorites.fetch
				cache: false
			return this

		modelFetched: ->
			@$el.html @template({objects : @favorites.toJSON()})
			console.log @favorites

			return this
