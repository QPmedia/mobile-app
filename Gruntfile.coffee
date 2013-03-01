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
		# delete build folder
		clean: ["build/"]

		# this is run after the requirejs task bundeled the app.
		# add the almond shim for require/define instead of full blown require.js
		concat:
			"build/release/app.js": ["vendor/js/libs/almond.js", "build/release/app.js"]

		# This task uses the MinCSS Node.js project to take all your CSS files in
		# order and concatenate them into a single CSS file named index.css.  It
		# also minifies all the CSS as well.  This is named app.css, because we
		# only want to load one stylesheet in index.html.
		cssmin:
			"build/release/css/index.css": ["build/dev/css/**/*.css"]

		# Takes the built require.js file and minifies it for filesize benefits.
		uglify:
			"build/release/app.min.js": ["build/release/app.js"]

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
					#hostname: "192.168.2.12"
					#keepalive: true
					base: 'build/release'

		requirejs:
			release:
				options:
					#baseUrl: "build/dev",
					mainConfigFile: "build/dev/app/scripts/bootstrap.js"
					out: "build/release/app.js"
					name: "bootstrap"
					# can be 'uglify' 'uglify2' 'closure'
					#optimize: "none"

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
					#config: 'config.rb'
					sassDir: "app/scss"
					imagesDir: "build/dev/app/images"
					fontsDir: "build/dev/app/fonts"
					cssDir: "build/dev/css"
					require: ["zurb-foundation","compass-normalize"]
					outputStyle: "expanded"
					relativeAssets: true
					raw: '''fonts_dir = "build/dev/app/fonts"
						sass_options = {:debug_info => true}
						add_import_path "#{Gem.loaded_specs[\'zurb-foundation\'].full_gem_path}/scss"'''

		# the subtasks are seperated so we can update specific files such as index via regarde-watcher
		# TODO: favicon, images
		copy:
			api:
				files: [
					src: ['api/**']
					dest: 'build/dev/'
					expand: true
				,
					src: ['api/**']
					dest: 'build/release/'
					expand: true
				]
			vendor:
				files: [
					src: ['vendor/**']
					dest: 'build/dev/'
					expand: true
				,
					src: ['vendor/js/modernizr-*.js']
					dest: 'build/release/'
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
				,
					src: 'index.html'
					dest: 'build/release/'
				]
			fonts:
				files: [
					src: ['app/fonts/**']
					dest: 'build/dev/'
					expand: true
				,
					src: ['app/fonts/**']
					dest: 'build/release/'
					expand: true
				]
			images:
				files: [
					src: ['app/images/**']
					dest: 'build/dev/'
					expand: true
				,
					src: ['app/images/**']
					dest: 'build/release/'
					expand: true
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
		'grunt-contrib-uglify',
		'grunt-contrib-coffee',
		'grunt-contrib-connect',
		'grunt-regarde',
		'grunt-contrib-livereload',
		'grunt-contrib-copy',
		'grunt-contrib-compass',
		'grunt-contrib-cssmin'
		]
		grunt.loadNpmTasks plugin


	grunt.registerTask 'default', [
		'clean', 'copy', 'coffee', 'compass',
		'livereload-start', 'connect', 'regarde'
		]

	grunt.registerTask "release", ['clean', 'copy', 'coffee', 'compass', 'cssmin', 'requirejs:release', 'concat', 'uglify']
