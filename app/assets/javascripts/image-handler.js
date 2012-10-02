$container = null;
catsURL    = "";
maxCats    = Math.round(($(window).height()/250) * ($(window).width()/250));
timer      = 5; //in secs

$(document).ready(function(){
  $container     = $('.cats');
  catsURL        = $(".cats").data("url");
  $container.imagesLoaded( function(){
    $container.masonry({
      itemSelector : '.cat-container',
      isFitWidth: true,
      isAnimated: false,
      isResizable: true,
      columnWidth: 100
    });
  });
  startTimer();
  setTimeout(function(){
    getMoreCats();
  },timer*1000);
});

function startTimer(){
  $('.timer').pietimer({
    seconds: timer,
    color: 'rgba(0, 0, 0, 0.8)',
    height: 16,
    width: 16
  });
  $('.timer').pietimer('start');
}

function getMoreCats(){
  //Get new cats and parse each JSON cat

  //fade out the container
  var $catsMain = $container.children("#cats-main");

  //recalculate max cat count
  maxCats    = ($(window).height()/250) * ($(window).width()/250);

  $catsMain.fadeOut(function(){
    data = {limit: maxCats}
    $.getJSON(catsURL, data, function(cats){
      $catsMain.html("");
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
        $catsMain.append(cat);
      }
      $container.imagesLoaded( function(){        
        $catsMain.fadeIn(function(){
          setTimeout(function(){
            getMoreCats();
          },timer*1000);          
          startTimer();
        });
        $(this).masonry('reload');
        
      });
    });    
  });

}
