(function() {

  require.config({
    paths: {
      zepto: "../../vendor/js/libs/zepto-1.0rc1",
      lodash: "../../vendor/js/libs/lodash-1.0.1",
      underscore: "../../vendor/js/libs/lodash-1.0.1",
      backbone: "../../vendor/js/libs/backbone-0.9.2",
      fastclick: "../../vendor/js/libs/fastclick",
      handlebars: "../../vendor/js/libs/handlebars-1.0rc3",
      swag: "../../vendor/js/libs/swag",
      text: "../../vendor/js/plugins/text-1.0.7",
      "backbone-deepmodel": "../../vendor/js/plugins/backbone-deepmodel-0.7.3",
      templates: "../templates",
      navigator: "utils/navigator"
    },
    shim: {
      zepto: {
        exports: "Zepto"
      },
      backbone: {
        deps: ["lodash", "zepto"],
        exports: "Backbone"
      },
      handlebars: {
        exports: "Handlebars"
      },
      "backbone-deepmodel": {
        deps: ["backbone"]
      },
      "backbone-super": {
        deps: ["backbone"]
      },
      "backbone-zombienation": {
        deps: ["backbone"]
      },
      "swag": {
        deps: ["handlebars"]
      }
    }
  });

  require(["main"]);

}).call(this);
