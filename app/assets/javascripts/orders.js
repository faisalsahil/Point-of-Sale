jQuery("#order").html('<%= escape_javascript(render :partial => "order_content") %>');

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

$(document).ready(function(){
    $('.save').click(function(products,order_products){
        products.quantity = products.quantity - order_products.quantity;
    });

});


function PrintDiv() {
        window.print();
}