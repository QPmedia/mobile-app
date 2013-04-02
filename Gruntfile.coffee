# This is the main application configuration file.  It is a Grunt
# configuration file, which you can learn more about here:
# https://github.com/cowboy/grunt/blob/master/docs/configuring.md
#
path       = require('path')
lrSnippet  = require('grunt-contrib-livereload/lib/utils').livereloadSnippet
modRewrite = require('connect-modrewrite');
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
					port: 8001
					hostname: '0.0.0.0'
					middleware: (connect, options) ->
						[	modRewrite(['^/cordova.js$ /vendor/phonegap-desktop/phonegap-desktop.js',
										'^/debugdata.json$ /vendor/phonegap-desktop/debugdata.json',
										'^/barcodescanner.js$ /vendor/phonegap-desktop/barcodescanner.js',
										'^/plugins/barcodescanner.json$ /vendor/phonegap-desktop/barcodescanner.json',
										]),
							lrSnippet,
							folderMount(connect, options.base),
							connect.static(options.base)
						]
			release:
				options:
					port: 8002
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
				tasks: ['sass']
			index:
				files: 'index.html'
				tasks: ['copy:index']
			vendor:
				files: ['vendor/**']
				tasks: ["copy:vendor"]
			templates:
				files: ['app/templates/**']
				tasks: ["copy:templates"]

		sass:
			dev:
				options:
					debugInfo: true
					style: "expanded"
				files:
					'build/dev/app/css/app.css': [
						'app/scss/reset.scss'
						'app/scss/base.scss'
						'app/scss/icons.scss'
						'app/scss/layout.scss'
						'app/scss/layout-*.scss'
						'app/scss/widgets.scss'
						'app/scss/widgets-*.scss'
					]
					'build/dev/app/css/theme.css': [
						'app/scss/theme/base.scss'
						'app/scss/theme/layout.scss'
						'app/scss/theme/layout-*.scss'
						'app/scss/theme/widgets.scss'
						'app/scss/theme/widgets-*.scss'
					]

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
			config:
				files: [
					src: 'config.xml'
					dest: 'build/release/'
				]
			icon:
				files: [
					src: 'icon.png'
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
			android:
				# www is a symlink
				files: [
					src: 'android/assets/cordova.js'
					dest: 'android/assets/www/cordova.js'
				,
					src: 'android/assets/barcodescanner.js'
					dest: 'android/assets/www/barcodescanner.js'
				]
		shell:
			android:
				command: 'ant -f android debug'
				options:
					stdout: true
			androidinstall:
				command: 'ant -f android debug install'
				options:
					stdout: true

	# load all required plugins the coffee-way
	for plugin in [
		'grunt-contrib-clean',
		'grunt-contrib-coffee',
		'grunt-contrib-concat',
		'grunt-contrib-connect',
		'grunt-contrib-copy',
		'grunt-contrib-cssmin'
		'grunt-contrib-livereload',
		'grunt-contrib-sass',
		'grunt-contrib-requirejs',
		'grunt-contrib-uglify',
		'grunt-regarde',
		'grunt-shell'
		]
		grunt.loadNpmTasks plugin


	grunt.registerTask 'default', [
		'clean', 'copy', 'coffee', 'sass',
		'livereload-start', 'connect:livereload','connect:release', 'regarde'
		]

	grunt.registerTask "release", ['clean', 'copy', 'coffee', 'sass', 'cssmin',
		'requirejs:release', 'concat', 'uglify', 'shell:androidinstall']
