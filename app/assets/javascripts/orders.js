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
        var divToPrint = document.getElementById('print_div');
        var popupWin = window.open( '_blank', 'width=300,height=300');

        var totalAmount = $('#total_amount');
        $('#total_amount1').html(totalAmount);

        var grossAmount = $('#gross_amount');
        $('#gross_amount1').html(grossAmount);

        var discountAmount = $('#discount_amount');
        $('#discount_amount1').html(discountAmount);

        var netAmount = $('#net_amount');
        $('#net_amount1').html(netAmount);

        popupWin.document.open();
        popupWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</html>');
        popupWin.document.close();
}