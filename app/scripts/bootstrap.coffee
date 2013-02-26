# Set the require.js configuration for your application.
require.config
	paths:

		# Libraries
		zepto:                    "../../vendor/js/libs/zepto-1.0rc1"
		lodash:                   "../../vendor/js/libs/lodash-1.0.1"
		underscore:               "../../vendor/js/libs/lodash-1.0.1"
		backbone:                 "../../vendor/js/libs/backbone-0.9.2"
		fastclick:                "../../vendor/js/libs/fastclick"
		swig:                     "../../vendor/js/libs/swig"
		# Plugins
		text:                     "../../vendor/js/plugins/text-1.0.7"
		"backbone-deepmodel":     "../../vendor/js/plugins/backbone-deepmodel-0.7.3"
		"backbone-zombienation":  "../../vendor/js/plugins/backbone-zombienation"
		templates:                "../templates"
		navigator:                "utils/navigator"
		foundation:             "../../vendor/js/libs/foundation"
		"foundation-alerts":      "../../vendor/js/plugins/foundation.alerts"
		"foundation-cookie":      "../../vendor/js/plugins/foundation.cookie"
		"foundation-placeholder": "../../vendor/js/plugins/foundation.placeholder"
		"foundation-section":     "../../vendor/js/plugins/foundation.section"
		"foundation-topbar":      "../../vendor/js/plugins/foundation.topbar"
		"iscroll":                "../../vendor/js/plugins/iscroll"

	shim:
		zepto:
			exports: "Zepto"

		backbone:
			deps: ["lodash", "zepto"]
			exports: "Backbone"

		swig:
			deps: ["lodash"]

		"backbone-deepmodel":
			deps: ["backbone"]

		"backbone-super":
			deps: ["backbone"]

		"backbone-zombienation":
			deps: ["backbone"]

		foundation:
			deps: ["zeptop"]

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
