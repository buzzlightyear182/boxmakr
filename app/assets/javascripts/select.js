$(document).ready(function(){
  $('.countries').select2();
  $('.companies').select2();
  $('.country-filter').select2();

  $('.datepicker-input').datepicker({
    format: 'dd M yyyy'  });
});