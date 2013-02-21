# Set the require.js configuration for your application.
require.config
  paths:

    # Libraries
    zepto: "../../assets/js/libs/zepto-1.0rc1"
    lodash: "../../assets/js/libs/lodash-1.0.1"
    backbone: "../../assets/js/libs/backbone-0.9.2"
    fastclick: "../../assets/js/libs/fastclick"
    recognizr: "../../assets/js/libs/recognizr-0.3.0"
    handlebars: "../../assets/js/libs/handlebars-1.0rc3"

    # Plugins
    text: "../../assets/js/plugins/text-1.0.7"
    "backbone-deepmodel": "../../assets/js/plugins/backbone-deepmodel-0.7.3"
    "backbone-super": "../../assets/js/plugins/backbone-super"
    "backbone-zombienation": "../../assets/js/plugins/backbone-zombienation-0.1.0"
    templates: "../templates"
    navigator: "core/navigator"
    scaffold: "core/scaffold"
    components: "core/components"

  shim:
    zepto:
      exports: "Zepto"

    backbone:
      deps: ["lodash", "zepto"]
      exports: "Backbone"

    handlebars:
      exports: "Handlebars"

    "backbone-deepmodel":
      deps: ["backbone"]

    "backbone-super":
      deps: ["backbone"]

    "backbone-zombienation":
      deps: ["backbone"]

require ["main"]