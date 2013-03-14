define ["app","text!templates/login.html","utils/remotedata"], (app, template, remote) ->
	class LoginView extends Backbone.View
		template : swig.compile(template, { filename: "login" })

		events:
			'submit form#loginform': 'login'

		initialize: (options) ->
			@render

		render: ->
			@$el.append @template({user:app.user.toJSON()})
			return this

		login: ->
			username = @$('#username').val()
			pw = @$('#password').val()
			console.log(username)
			# make auth accept a callback with status etc.
			remote.post "#{app.API_URL}token/"
				,
					username: username
					password: pw
				,
					success: (data)->
						app.user.set("username", username)
						app.user.set("token", data.token)
						app.router.navigate('!/start', {trigger: true})
					error: (xhr) ->
						alert "fehler: " + xhr.status
			#app.user.authenticate username, pw
