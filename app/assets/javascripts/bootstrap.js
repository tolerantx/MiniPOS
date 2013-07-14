jQuery(function() {
  $("a[rel=popover]").popover();
  $(".tooltip").tooltip();
  $("a[rel=tooltip]").tooltip();
  createAutoClosingAlert(".alert", 3000);

  function createAutoClosingAlert(selector, delay) {
    var alert = $(selector).alert();
    window.setTimeout(function() { alert.alert('close') }, delay);
  }
});
