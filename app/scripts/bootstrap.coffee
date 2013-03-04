# Set the require.js configuration for your application.
require.config
	paths:

		# Libraries
		zepto:                    "../../vendor/js/libs/jquery"
		lodash:                   "../../vendor/js/libs/lodash-1.0.1"
		underscore:               "../../vendor/js/libs/lodash-1.0.1"
		backbone:                 "../../vendor/js/libs/backbone-0.9.2"
		fastclick:                "../../vendor/js/libs/fastclick"
		hammer:                   "../../vendor/js/libs/hammer"
		swig:                     "../../vendor/js/libs/swig"
		foundation:               "../../vendor/js/libs/foundation"
		# Plugins
		text:                     "../../vendor/js/plugins/text-1.0.7"
		"jquery-hammer":          "../../vendor/js/plugins/jquery.hammer"
		"backbone-deepmodel":     "../../vendor/js/plugins/backbone-deepmodel-0.7.3"
		"backbone-zombienation":  "../../vendor/js/plugins/backbone-zombienation"
		"backbone-fetch-cache":   "../../vendor/js/plugins/backbone-fetch-cache"
		"backbone-tastypie":      "../../vendor/js/plugins/backbone-tastypie"
		templates:                "../templates"
		navigator:                "utils/navigator"
		"foundation-alerts":      "../../vendor/js/plugins/foundation.alerts"
		"foundation-cookie":      "../../vendor/js/plugins/foundation.cookie"
		"foundation-placeholder": "../../vendor/js/plugins/foundation.placeholder"
		"foundation-section":     "../../vendor/js/plugins/foundation.section"
		"foundation-topbar":      "../../vendor/js/plugins/foundation.topbar"
		"iscroll":                "../../vendor/js/plugins/iscroll"

	shim:
		zepto:
			exports: "jQuery"

		hammer:
			deps: ["zepto"]
			exports: "Hammer"

		backbone:
			deps: ["lodash", "zepto"]
			exports: "Backbone"

		swig:
			deps: ["lodash"]
			exports: "swig"

		"backbone-deepmodel":
			deps: ["backbone"]

		"backbone-super":
			deps: ["backbone"]

		"backbone-zombienation":
			deps: ["backbone"]

		"backbone-fetch-cache":
			deps: ["backbone"]

		"backbone-tastypie":
			deps: ["backbone"]

		"jquery-hammer":
			deps: ["zepto", "hammer"]

		foundation:
			deps: ["zepto"]

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
