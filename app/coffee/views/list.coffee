define (require) ->
  $ = require("zepto")
  _ = require("lodash")
  app = require("app")
  Scaffold = require("scaffold")
  Item = (->
    Scaffold.View.extend
      tagName: "li"
      template: _.template(require("text!templates/item.jst"))
      render: ->
        $(@el).html @template(@model.toJSON())
        this

  )()
  List = (->
    Model = Scaffold.Model.extend(defaults:
      id: null
      name: "Animal"
    )
    Collection = Scaffold.Collection.extend(
      model: Model
      url: "/api/animals.json"
    )
    Scaffold.View.extend
      tagName: "ul"
      template: _.template(require("text!templates/list.jst"))
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
