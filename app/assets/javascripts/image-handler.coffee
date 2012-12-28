class CatList extends Backbone.View
  el: '.cats'
  initialize: ->
    _.bindAll @
    @collection = new Cats
    @collection.bind 'add', @appendCat
    @collection.bind 'fetched', @render

  render: ->
    $(@el).html ''
    $(@el).append '<ul></ul>'
    for cat in @collection.models
      @appendCat cat
    @
  appendCat: (cat)->
    @doAppend cat
  doAppend: (model)->
    console.debug("Appending")
    $('ul', @el).append "<li>#{model.get 'image' }</li>"

class Cats extends Backbone.Collection
  @model: Cat
  url: '/cats'
  initialize: ->
    _.bindAll @
  fetch: ->
    super.success (response) =>
      @trigger 'fetched'

class Cat extends Backbone.Model
  defaults:
    id: 1
    image: ""
    guid: ""
    title: ""

$ ->
  window.cat_list = new CatList


