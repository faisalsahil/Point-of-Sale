$(document).ready(function(){
  $('.take-print').click(function(){
    window.print();
  });

    $('.datepicker').datepicker({
        format: "dd/mm/yyyy",
        // daysOfWeekDisabled: "0",
        autoclose: true,
        todayHighlight: true
    });
});
