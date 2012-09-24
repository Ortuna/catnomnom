$container = null;
catsURL = "";
speed = 1;

$(document).ready(function(){

  $container     = $('.cats');
  catsURL        = $(".cats").data("url");
  $container.imagesLoaded( function(){
    $container.masonry({
      itemSelector : '.cat-container',
      isFitWidth: true,
      isAnimated: true,
      isResizable:true,
      columnWidth: 300,
      animationOptions: {
        duration: 300,
        easing: 'linear',
        queue: false
      }      
    });
  });

  interval = setInterval(function(){
    getMoreCats();
  },5000);
});

function getMoreCats(){
  //Get new cats and parse each JSON cat
  $.getJSON(catsURL,function(cats){
    $container.find("#cats-main").html("");
    for(var i = 0; i < cats.length;i++){
      var cat = $("<div class='cat-container shadow masonry-brick'></div>");
      cat.append("<div class='cat'><a href='"  
        + cats[i].image 
        + " target='_blank'><img src='" 
        + cats[i].image 
        + " alt='" 
        + cats[i].title 
        +"'></a><p>" 
        + cats[i].title 
        + "</p></div>"
      );
      $container.find("#cats-main").append(cat);
    }
    $container.imagesLoaded( function(){
      $(this).masonry('reload');
    });
  });
}
