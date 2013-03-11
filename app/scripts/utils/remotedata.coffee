###
###
define (require) ->
	$ = require("jquery")
	app = require("app")
	noop = ->


	# fetch model
	fetch = (model, options) ->
		complete = options.complete or noop
		success = options.success or noop
		error = options.error or noop
		model.fetch
			success: (model, response) ->
				success model, response
				complete()

			error: (model, response) ->
				error model, response
				complete()


	save = (model, options) ->
		complete = options.complete or noop
		success = options.success or noop
		error = options.error or noop
		model.save
			wait: options.wait
			success: (model, response) ->
				success model, response
				complete()

			error: (model, response) ->
				error model, response
				complete()



	# do an AJAX get
	get = (url, options) ->
		complete = options.complete or noop
		success = options.success or noop
		error = options.error or noop
		$.ajax
			type: "GET"
			url: url
			dataType: options.dataType or "text"
			timeout: options.timeout
			headers: options.headers
			async: options.async or true
			global: options.global or true
			context: options.context
			success: (data, status, xhr) ->
				success data
				complete()

			error: (xhr) ->
				error xhr.responseText

			complete: complete



	# don an AJAX post
	post = (url, data, options) ->
		complete = options.complete or noop
		success = options.success or noop
		error = options.error or noop
		$.ajax
			type: "POST"
			data: data
			url: url
			contentType: options.contentType
			dataType: options.dataType
			timeout: options.timeout
			headers: options.headers
			async: options.async
			global: options.global
			context: options.context
			success: (data, status, xhr) ->
				success data
				complete()

			error: (xhr) ->
				error xhr

			complete: complete


	exports =
		fetch: fetch
		save: save
		get: get
		post: post

	app.registerModule "data", exports
	exports

