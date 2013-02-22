# This is the main application configuration file.  It is a Grunt
# configuration file, which you can learn more about here:
# https://github.com/cowboy/grunt/blob/master/docs/configuring.md
#
path = require('path')
lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet
folderMount = (connect, point)->
	connect.static(path.resolve(point))

module.exports = (grunt) ->
	grunt.initConfig
		# The clean task ensures all files are removed from the dist/ directory so
		# that no files linger from previous builds.
		clean: ["dist/"]

		# The lint task will run the build configuration and the application
		# JavaScript through JSHint and report any errors.  You can change the
		# options for this task, by reading this:
		# https://github.com/cowboy/grunt/blob/master/docs/task_lint.md
		jslint:
			files: ["app/**/*.js"]
			directives:
				#browser: true,
				#unparam: true,
				#todo: true,
				white:true
				vars: true
				nomen:true
				predef: ["define", "Backbone"]

		# The concatenate task is used here to merge the almond require/define
		# shim and the templates into the application code.  It's named
		# dist/debug/require.js, because we want to only load one script file in
		# index.html.
		concat:
			"dist/debug/require.js": ["assets/js/libs/almond.js","dist/debug/require.js"]

		# This task uses the MinCSS Node.js project to take all your CSS files in
		# order and concatenate them into a single CSS file named index.css.  It
		# also minifies all the CSS as well.  This is named app.css, because we
		# only want to load one stylesheet in index.html.
		mincss:
			"dist/release/index.css": ["assets/css/**/*.css"]

		# Takes the built require.js file and minifies it for filesize benefits.
		uglify:
			"dist/release/require.js": ["dist/debug/require.js"]

		# 'grunt connect' will start both servers.
		# The second one will block (keepalive) and keep grunt and the servers running
		connect:
			livereload:
				options:
					port: 8000
					middleware: (connect, options) -> [lrSnippet, folderMount(connect, '.')]
			debug:
				options:
					keepalive: false
					port: 8000
			release:
				options:
					port: 8001
					#keepalive: true
					base: 'dist'

		requirejs:
			compile:
				options:
					#baseUrl: "path/to/base",
					mainConfigFile: "app/scripts/bootstrap.js"
					out: "dist/debug/require.js"
					name: "bootstrap"

		coffee:
			# compile:
			# 	files:
			# 	'path/to/result.js': 'path/to/source.coffee',
			# 	'path/to/another.js': ['path/to/sources/*.coffee', 'path/to/more/*.coffee']

			everything:
				expand: true
				cwd: '.'
				src: ['app/**/*?.coffee']
				dest: '.'
				ext: '.js'
		# watch:
		# 	coffee:
		# 		files: ['**/*.coffee','!node_modules/**/*.js']
		# 		tasks: ['coffee:everything']
		# 		options:
		# 			interrupt: true
		# TODO: maybe it is possible to only recompile changed files.
		# livereload only sends new files, so it is possible somehow
		regarde:
			lr:
				files: ['**/*.js','**/*.css','!node_modules/**/*.js']
				tasks: ['livereload']
			coffee:
				files: '**/*.coffee'
				tasks: ['coffee:everything']
			scss:
				files: '**/*.scss'
				tasks: ['compass']

		compass:
			dist:
				options:
					#bundleExec: true
					config: 'config.rb'

	# load all required plugins the coffee-way
	for plugin in [
		'grunt-contrib-concat',
		'grunt-contrib-clean',
		'grunt-contrib-requirejs',
		'grunt-jslint',
		'grunt-contrib-uglify',
		#'grunt-contrib-watch',
		'grunt-contrib-coffee',
		'grunt-contrib-connect',
		'grunt-regarde',
		'grunt-contrib-livereload',
		'grunt-contrib-compass'
		]
		grunt.loadNpmTasks plugin

	# The default task will remove all contents inside the dist/ folder, lint
	# all your code, precompile all the underscore templates into
	# dist/debug/templates.js, compile all the application code into
	# dist/debug/require.js, and then concatenate the require/define shim
	# almond.js and dist/debug/templates.js into the require.js file.
	#grunt.registerTask "default", ["clean", "requirejs", "concat"]
	grunt.registerTask('default', ['livereload-start', 'connect:livereload', 'regarde']);
	# The debug task is simply an alias to default to remain consistent with
	# debug/release.
	#grunt.registerTask "debug", "default"

	# The release task will run the debug tasks and then minify the
	# dist/debug/require.js file and CSS files.
	grunt.registerTask "release", "default min mincss"

	# The preflight task will lint and test your code, ready to be checked in to source control.
	grunt.registerTask "preflight", ["jslint"]
