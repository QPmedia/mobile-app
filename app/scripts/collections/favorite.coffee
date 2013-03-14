define ["app","backbone-pageable","models/favorite"]
		,(app, PageableCollection, Favorite) ->

	class FavoriteCollection extends PageableCollection
		model: Favorite
		sync: app.sync_with_token
		initialize: ->
			@url = "#{app.API_URL}favorite/"

		parse: (data) ->
			return data.results
