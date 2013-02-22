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
		clean: ["build/"]

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
		# shim and the templates into the application code.
		concat:
			"build/release/app.js": ["vendor/js/libs/almond.js", "build/release/app.js"]

		# This task uses the MinCSS Node.js project to take all your CSS files in
		# order and concatenate them into a single CSS file named index.css.  It
		# also minifies all the CSS as well.  This is named app.css, because we
		# only want to load one stylesheet in index.html.
		mincss:
			"build/release/app.css": ["assets/css/**/*.css"]

		# Takes the built require.js file and minifies it for filesize benefits.
		uglify:
			"dist/release/require.js": ["dist/debug/require.js"]

		# 'grunt connect' will start both servers.
		# The second one will block (keepalive) and keep grunt and the servers running
		connect:
			livereload:
				options:
					base: 'build/dev'
					port: 8000
					middleware: (connect, options) -> [lrSnippet, folderMount(connect, options.base)]
			release:
				options:
					port: 8001
					#keepalive: true
					base: 'build/release'

		requirejs:
			release:
				options:
					#baseUrl: "build/dev",
					mainConfigFile: "build/dev/app/scripts/bootstrap.js"
					out: "build/release/app.js"
					name: "bootstrap"

		coffee:
			everything:
				expand: true
				cwd: '.'
				src: ['app/scripts/**/*.coffee']
				dest: 'build/dev/'
				ext: '.js'

		# TODO: maybe it is possible to only recompile changed files.
		# livereload only sends new files, so it is possible somehow
		regarde:
			lr:
				files: [
					'build/dev/**/*.js',
					'build/dev/**/*.css',
					'build/dev/**/*.html',
					'build/dev/index.html',
				]
				tasks: ['livereload']
			coffee:
				files: ['app/scripts/**/*.coffee']
				tasks: ['coffee:everything']
			scss:
				files: 'app/scss/**/*.scss'
				tasks: ['compass']
			index:
				files: 'index.html'
				tasks: ['copy:index']
			vendor:
				files: ['vendor/**']
				tasks: ["copy:vendor"]
			templates:
				files: ['app/templates/**']
				tasks: ["copy:templates"]

		compass:
			dist:
				options:
					#bundleExec: true
					config: 'config.rb'

		# the subtasks are seperated so we can update specific files such as index via regarde-watcher
		copy:
			api:
				files: [
					src: ['api/**']
					dest: 'build/dev/'
					expand: true
				]
			vendor:
				files: [
					src: ['vendor/**']
					dest: 'build/dev/'
					expand: true
				]
			templates:
				files: [
					src: ['app/templates/**']
					dest: 'build/dev/'
					expand: true
				]
			index:
				files: [
					src: 'index.html'
					dest: 'build/dev/'
				]
			app:
				# fake app.js, let requirejs load scripts
				files: [
					src: 'vendor/js/libs/require.js'
					dest: 'build/dev/app.js'
				]

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
		'grunt-contrib-copy',
		'grunt-contrib-compass'
		]
		grunt.loadNpmTasks plugin

	# The default task will remove all contents inside the dist/ folder, lint
	# all your code, precompile all the underscore templates into
	# dist/debug/templates.js, compile all the application code into
	# dist/debug/require.js, and then concatenate the require/define shim
	# almond.js and dist/debug/templates.js into the require.js file.
	#grunt.registerTask "default", ["clean", "requirejs", "concat"]
	grunt.registerTask('default', ['clean', 'copy', 'coffee', 'compass', 'livereload-start', 'connect', 'regarde']);
	# The debug task is simply an alias to default to remain consistent with
	# debug/release.
	#grunt.registerTask "debug", "default"

	# The release task will run the debug tasks and then minify the
	# dist/debug/require.js file and CSS files.
	grunt.registerTask "release", ['clean', 'copy', 'coffee', 'compass', 'requirejs:release']

	# The preflight task will lint and test your code, ready to be checked in to source control.
	grunt.registerTask "preflight", ["jslint"]
