$container = null;
catsURL = "";
speed = 1;

$(document).ready(function(){

  $container     = $('.cats');
  catsURL        = $(".cats").data("url");
  var pageHeight = $(window).height();
  $container.css("max-height", pageHeight-20);
  $("body").css("max-height",pageHeight-20);
  $container.imagesLoaded( function(){
    $(".cat-container").last().appear(function(){
      getMoreCats();
    });
    $container.masonry({
      itemSelector : '.cat-container',
      isFitWidth: true,
      isAnimated: true,
      animationOptions: {
        duration: 300,
        easing: 'linear',
        queue: false
      }      
    });
  });

  interval = setInterval(function(){
    $container.offset({ top: $container.offset().top - speed });
    $container.css("max-height", (pageHeight-$container.offset().top)-speed);
  },50);
});

function getMoreCats(){
  //Get new cats and parse each JSON cat
  $.getJSON(catsURL,function(cats){
    for(var i = 0; i < cats.length;i++){
      var cat = $("<div class='cat-container shadow masonry-brick'></div>");
      cat.append("<div class='cat'></div>").append("<a href='"  + cats[i].image + " target='_blank'><img src='" + cats[i].image + " alt='" + cat.title +"'></a>");
      $container.find("#cats-main").append(cat);
      $container.masonry( 'reload' );
      // $container.masonry('appended',cat,true);
    }
  
  //Make last appearance of a cat get more cats
  $(".cat-container").last().appear(function(){
    getMoreCats();
  });
  });
}
