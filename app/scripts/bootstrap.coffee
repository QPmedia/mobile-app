# Set the require.js configuration for your application.
require.config
	paths:

		# Libraries
		jquery:                   "../../vendor/js/libs/jquery"
		underscore:               "../../vendor/js/libs/lodash-1.0.1"
		backbone:                 "../../vendor/js/libs/backbone-0.9.2"
		fastclick:                "../../vendor/js/libs/fastclick"
		hammer:                   "../../vendor/js/libs/hammer"
		"hammer-jquery":                   "../../vendor/js/libs/hammer-jquery"
		swig:                     "../../vendor/js/libs/swig"
		foundation:               "../../vendor/js/libs/foundation"
		# Plugins
		text:                     "../../vendor/js/plugins/text-1.0.7"
		"backbone-pageable":      "../../vendor/js/plugins/backbone-pageable"
		"backbone-zombienation":  "../../vendor/js/plugins/backbone-zombienation"
		"backbone-fetch-cache":   "../../vendor/js/plugins/backbone-fetch-cache"
		templates:                "../templates"
		navigator:                "utils/navigator"
		"foundation-alerts":      "../../vendor/js/plugins/foundation.alerts"
		"foundation-cookie":      "../../vendor/js/plugins/foundation.cookie"
		"foundation-placeholder": "../../vendor/js/plugins/foundation.placeholder"
		"foundation-section":     "../../vendor/js/plugins/foundation.section"
		"foundation-topbar":      "../../vendor/js/plugins/foundation.topbar"
		"jquery-serialize-object":"../../vendor/js/plugins/jquery.serialize-object.compiled"
		"waypoints":              "../../vendor/js/plugins/waypoints"

	shim:
		jquery:
			exports: "jQuery"

		"jquery-serialize-object":
			deps: ["jquery"]

		"waypoints":
			deps: ["jquery"]

		hammer:
			deps: ["jquery"]
			exports: "Hammer"

		"hammer-jquery":
			deps: ["jquery"]
			exports: "Hammer"

		backbone:
			deps: ["underscore", "jquery"]
			exports: "Backbone"

		swig:
			deps: ["underscore", "utils/filter", "utils/tags"]
			exports: "swig"

		"backbone-deepmodel":
			deps: ["backbone"]

		"backbone-pageable":
			deps: ["backbone"]

		"backbone-zombienation":
			deps: ["backbone"]

		foundation:
			deps: ["jquery"]

		"foundation-alerts":
			deps: ["foundation"]

		"foundation-cookie":
			deps: ["foundation"]

		"foundation-placeholder":
			deps: ["foundation"]

		"foundation-section":
			deps: ["foundation"]

		"foundation-topbar":
			deps: ["foundation"]

require ["main"]
