# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ = jQuery
width  = 0
height = 0
cats_url = ""
cats = []

jQuery ->
  cats_url = $(".cats").data("url")

  width   = $(document).width()
  height  = $(document).height()
  
  picture_width = $(".cat-container").first().width()
  spacing = Math.abs(width - (picture_width*4))/5
  
  x = spacing
  y = spacing

  get_more_cats()
  $(".cat-container").each (index, element)->

    #set location
    $(this).css("left", x)
    $(this).css("top", y)

    #increment x and y
    x += spacing+picture_width
    if(index == 3 || index == 7)
      x  = spacing
      y += spacing+picture_width

    #resize images
    resize_image(element)
      
    setTimeout (-> toggleit(element)), Math.random()*5000
    return true
get_more_cats = ->
  $.getJSON(cats_url, (data)-> cats = data)

resize_image = (element)->
  $image = $(element).find("img")
  if($image.length > 0)
    orig_height = $image.height
    orig_width  = $image.width
    new_width   = 200
    new_height  = 0
    while new_height < 200 || new_width < 200
      new_width += 100
      new_height  = orig_height/orig_width*new_width
    $image.css("width", new_width)
    $image.css("height", new_height)

toggleit = (element)->
  if(cats.length > 1 && $(element).css("display") == "none")
    random_index = Math.round(Math.random()*cats.length)
    new_cat = $("<img>")
    new_cat.attr("src", cats[random_index].image)
    $(element).find(".cat").html($(new_cat))
    cats.splice(random_index, 1)
    resize_image(element)
  else
    get_more_cats()
  $(element).fadeToggle('slow', -> setTimeout (-> toggleit(element)), Math.random()*5000)
  return true