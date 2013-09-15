// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.autocomplete
//= require lib/jquery.livequery
//= require lib/jquery.watch
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(function(){
  $('#btn-sign-out').click( function(e) {
    e.preventDefault();
    $('#form_signout .btn-link').click();
  })
})

new function($) {
  $.fn.myAutocomplete = function(settings) {
    settings = settings || {};
    this.each(function() {
      var searchUrl = $(this).attr('data-search-url');
      var postUrl   = $(this).attr('data-post-url');

      $(this).autocomplete({
        source: searchUrl,
        change: function(event, ui) {
          input     = $(this)
          if (!ui.item && postUrl) {
            $.post(postUrl, { name: $(this).val() }, function(data) {
              input.parent().find('input.hidden-id').val(data.id);
            }, 'json');
            return false;
          }
        },
        select: function(event, ui) {
          $(this).parent().find('input.hidden-id').val(ui.item.id);
          // $('a.add_nested_fields').trigger('click')
        },
        autoFocus: true
      });
    });
  }
}(jQuery);
