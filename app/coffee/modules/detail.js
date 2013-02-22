(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var $, Handlebars, Model, Scaffold, View, app, swag;
    $ = require("zepto");
    app = require("app");
    Scaffold = require("scaffold");
    Handlebars = require("handlebars");
    swag = require("swag");
    Model = (function(_super) {

      __extends(Model, _super);

      function Model() {
        return Model.__super__.constructor.apply(this, arguments);
      }

      Model.prototype.url = function() {
        return "/api/animals/" + this.id + ".json";
      };

      return Model;

    })(Scaffold.Model);
    return View = (function(_super) {

      __extends(View, _super);

      function View() {
        return View.__super__.constructor.apply(this, arguments);
      }

      View.prototype.template = Handlebars.compile(require("text!templates/detail.handlebars"));

      View.prototype.events = {};

      View.prototype.initialize = function(options) {
        this.model = new Model({
          id: options.id
        });
        return this.bindTo(this.model, "change", this.modelFetched);
      };

      View.prototype.render = function() {
        this.model.fetch();
        return this;
      };

      View.prototype.modelFetched = function() {
        this.$el.html(this.template(this.model.toJSON()));
        app.trigger("headerbar:update", {
          title: this.model.get("name")
        });
        return this;
      };

      return View;

    })(Scaffold.View);
  });

}).call(this);
