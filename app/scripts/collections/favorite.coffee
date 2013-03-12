define ["app","backbone-pageable","models/favorite"]
		,(app, PageableCollection, Favorite) ->
	class FavoriteCollection extends PageableCollection
		model: Favorite

		initialize: ->
			@url = app.API_URL+"favorite/"
		parse: (data) ->
			return data.results
