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
//= require bootstrap-sprockets
//= require_tree ./application
//= require_tree ./idea

$(function() {
  // With slight modifications from http://stackoverflow.com/a/12714767/2199687
  var hashTagActive = "";
  $("#page_pages__show__user_rules a.anchor").click(function (event) {
    var hash = this.hash;

    if(hashTagActive != hash) { //this will prevent if the user click several times the same link to freeze the scroll.
      event.preventDefault();
      //calculate destination place
      var dest = 0;
      if ($(this.hash).offset().top > $(document).height() - $(window).height()) {
        dest = $(document).height() - $(window).height();
      } else {
        dest = $(this.hash).offset().top;
      }

      if (dest > $(window).height()/2) {
        dest =  dest - $(window).height()/2;
      }

      //go to destination
      $('html,body').animate({scrollTop: dest }, 150, 'swing', function() {
        window.location.hash = hash;
        window.scroll(0, dest);
      });


      hashTagActive = hash;
    }
  });

  var hash = window.location.hash;
  if ($("body").attr('id') == 'page_pages__show__user_rules' && hash.length != 0) {
    $("a.anchor[href='"+hash+"']").click();
  }
});
