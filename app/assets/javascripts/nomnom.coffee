class CatList extends Backbone.View
  el: '.cats'
  initialize: ->
    _.bindAll @
    @collection = new Cats
    @collection.bind 'add', @appendCat
    @collection.bind 'fetched', @render
    @collection.list = @

  render: ->
    $(@el).html ''
    $(@el).append '<ul></ul>'
    for cat in @collection.models
      @appendCat cat
    $(@el).imagesLoaded =>
      if $(@el).data 'masonry'
        $(@el).masonry 'reload'
      else
        $(@el).masonry
          itemSelector: 'li'
      $(@el).removeClass('invisible')
    @
  appendCat: (cat)->
    @doAppend cat

  doAppend: (model)->
    $('ul', @el).append "<li>
                          <a target=\"_blank\" href=\"#{model.get 'image' }\">
                            <img src=\"#{model.get 'image' }\">
                          </a>
                        </li>"

class Cats extends Backbone.Collection
  @model: Cat
  url: "/cats"
  initialize: ->
    _.bindAll @
  fetch: ->
    @setCatLimit()
    super.success (response) =>
      $(@list.el).addClass("invisible")
      @trigger 'fetched'
  setCatLimit: ->
    limit = Math.floor($(document).width() / 250) * 3
    @url   = "/cats/#{limit}"

class Cat extends Backbone.Model
  defaults:
    id: 1
    image: ""
    guid: ""
    title: ""

$ ->
  window.cat_list = new CatList
  window.cat_list.collection.fetch()
  setInterval ( ->
    window.cat_list.collection.fetch()    
  ), 10000

