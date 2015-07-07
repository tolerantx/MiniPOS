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
//= require lib/jquery.jqprint-0.3
//= require twitter/bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require turbolinks
//= require mini_pos
//= require_tree .

$(function(){
  $('#btn-sign-out').click( function(e) {
    e.preventDefault();
    $('#form_signout .btn-link').click();
  })

  $('.input-daterange').datepicker({format: 'dd/mm/yyyy', language: 'es'});
  $('.input-daterange input').on('changeDate', function(e) {
    $(this).datepicker('hide');
  });
})
