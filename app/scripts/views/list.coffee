define (require) ->
  $ = require("zepto")
  _ = require("lodash")
  app = require("app")
  Backbone = require("backbone")
  require('backbone-zombienation')
  require('backbone-deepmodel')
  Handlebars = require('handlebars')
  Item = (->
    Backbone.View.extend
      tagName: "li"
      template: Handlebars.compile(require("text!templates/item.html"))
      render: ->
        $(@el).html @template(@model.toJSON())
        this

  )()
  List = (->
    Model = Backbone.Model.extend(defaults:
      id: null
      name: "Animal"
    )
    Collection = Backbone.Collection.extend(
      model: Model
      url: "/api/animals.json"
    )
    Backbone.View.extend
      tagName: "ul"
      #template: _.template(require("text!templates/list.html"))
      template: Handlebars.compile(require("text!templates/list.html"))
      events: {}
      
      # Respond to UI events, calling named functions in this object.
      # These events will automatically be cleaned up when the view is hidden.
      # Example:
      # "click .check"              : "toggleDone",
      # "dblclick div.todo-text"    : "edit"
      initialize: ->
        @collection = new Collection()
        @bindTo @collection, "add", @addOne
        @bindTo @collection, "reset", @addAll
        
        #app.trigger('headerbar:update', {
        #          title: 'Choose your weapon!'
        #        });
        @collection.fetch()

      render: ->
        @$el.html @template()
        this

      addOne: (item) ->
        view = new Item(model: item)
        view.render()
        @$el.append view.el
        @addChild view

      addAll: ->
        @disposeChildren()
        @collection.each @addOne, this

  )()
  List

