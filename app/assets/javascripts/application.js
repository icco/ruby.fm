// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.readyselector
//= require turbolinks
//= require plyr
//= require chart.min

// Get TL working
Turbolinks.enableTransitionCache();

// http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links
// Enable the player
var ready;

ready = function() {
  var player = plyr.setup(document.querySelector(".js-plyr"),
    {
      html: ["<div class='player-controls'>", "</div>"].join("\n"),
      seekTime: 30,
      volume: 8,
      tooltips: { controls: false, seek: false }
    }
  );

  // Easily access the player
  player = player[0]
  var media = player.media;

  $("[data-plyr='pause']").hide();

  // Toggle play pause button
  media.addEventListener("playing", function() {
    $("[data-plyr='play']").hide();
    $("[data-plyr='pause']").show();
  });

  media.addEventListener("pause", function() {
    $("[data-plyr='play']").show();
    $("[data-plyr='pause']").hide();
  });

  // Toggle play on click of player background
  $('.js-toggle-play').on("click", function(){
    player.togglePlay();
  });

  // Hide play button on first play
  media.addEventListener("play", function() {
    $(".js-play-hide").hide();
  });
};
