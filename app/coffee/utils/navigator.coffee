###
Controls the navigation of the pages within the app.
###
define (require) ->
  $ = require("zepto")
  init: (options) ->
    
    # We must set a base container element where we attach all views to.
    throw new Error("Option `container` must be set on page navigator")  unless options.container
    @container = options.container

  
  # Swaps out the current view for the new one,
  # destroying the old view in the process.
  # TODO look into how to handle a page transition here!
  changeView: (newView) ->
    @currentView.dispose()  if @currentView and @currentView.dispose
    @currentView = newView
    
    # Render the new view into our main DOM element
    # Note this used to use .html() instead of .empty().append()
    # But there is an issue with using .html():
    # http://tbranyen.com/post/missing-jquery-events-while-rendering
    @currentView.render()
    
    #$(this.container).html(this.currentView.el);
    $(@container).empty().append @currentView.el
    
    # Let the view know we have finished rendering.
    @currentView.wasRendered()
