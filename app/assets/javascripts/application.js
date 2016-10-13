//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-switch

$(function() {
  $('.alert').delay(1000).slideUp(500);
  $("[name='link[active]']").bootstrapSwitch;
});


