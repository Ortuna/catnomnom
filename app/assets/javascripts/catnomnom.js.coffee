# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ = jQuery
width  = 0
height = 0
cats_url = "" #URL for JSON data
cats = [] # Array of all the cat we have 
lock = false

jQuery ->
  cats_url = $(".cats").data("url")
  fix_cat_positions()
  $(window).resize ->
    fix_cat_positions()
  $(".cat-container").each (index, element)->
    setTimeout (-> toggleit(element)), Math.random()*10000
fix_cat_positions = ->
  width   = $(document).width()
  height  = $(document).height()
  
  #calculate the spacing for each cat and space them
  #evenly
  picture_width = $(".cat-container").first().width()
  picture_height = $(".cat-container").first().height()
  spacing_x = Math.abs(width - (picture_width*4))/5
  spacing_y = Math.abs(height - (picture_height*2))/4

  x = spacing_x
  y = spacing_y

  get_more_cats()
  $(".cat-container").each (index, element)->

    #set location
    $(this).css("left", x)
    $(this).css("top", y)

    #increment x and y
    x += spacing_x+picture_width
    if(index == 3 || index == 7)
      x  = spacing_x
      y += spacing_y+picture_width

    #resize images
    resize_image(element)        
    return true

#If the cats array is empty
#go and get more cats from
#the cats AJAX URL
get_more_cats = ->
  if cats.length > 0 || lock
    return
  lock = true
  $.getJSON(cats_url, (data)-> 
    cats = data
    lock = false
    )


#Given an element(mainly the cat div)
#Resize and translate the image to be 
#centered on a 200x200px square
resize_image = (element)->
  $image = $(element).find("img")
  $image.load(->
    if($image.length > 0)
      orig_height = $image.height()
      orig_width  = $image.width()
      new_width   = 200
      new_height  = 1

      while new_width < 200 || new_height < 200
        new_width += 100
        new_height = (orig_height/orig_width) * new_width

      pos_x = (new_width-200)/2
      pos_y = (new_height-200)/2

      $image.css("position", "relative")
      $image.css("left", -1 * pos_x)
      $image.css("top",  -1 * pos_y)
      $image.css("width", new_width)
      $image.css("height", new_height)
  )



#Toggles an element to fade in and out
#While fadded out change the cats image
#URL so it is a new cat.  If cats are 
#empty go and fetch a fresh set from the
#AJAX URL 
toggleit = (element)->
  if(cats.length > 0 && $(element).css("display") == "none")
    #replace with random cat while the element is not visible
    random_index = Math.round(Math.random()*cats.length)
    if(typeof cats[random_index] == "object")
      new_cat = $("<img>")
      new_cat.attr("src", cats[random_index].image)
      $(element).find(".cat a").html($(new_cat))
      $(element).find(".cat a").attr("href", cats[random_index].image)
      cats.splice(random_index, 1)
      resize_image(element)
  else
    get_more_cats()
  if($(element).css("display") == "none")
    $(element).fadeIn('fast', -> setTimeout (-> toggleit(element)), 5000+(Math.random()*10000))
  else
    $(element).fadeOut('fast',-> setTimeout (-> toggleit(element)), (Math.random()*5000))
  return true