// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require tether
//= require bootstrap-sprockets
//= require_tree .

$(document).on('ready', function(){

  // Filter search
  $('.live-search-list .ck-button').each(function(){
    $(this).attr('data-search-term', $(this).text().toLowerCase());
  });
  $('.live-search-box').on('keyup', function(){
  var searchTerm = $(this).val().toLowerCase();
    $('.live-search-list .ck-button').each(function(){
      if ($(this).filter('[data-search-term *= ' + searchTerm + ']').length > 0 || searchTerm.length < 1) {
          $(this).show();
      } else {
          $(this).hide();
      }
    });
  });

  $('#clearPantry').on('click', function(e) {
    $('input:checkbox').attr('checked',false);
  });

});
