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

    $('.purchase_order_id').on('change', function(){
        var purchase_order_id = $(this).val();
        var product_id = $(this).attr('product_id');
        if (purchase_order_id)
        {
            $.ajax({
                url: "/purchase_orders/"+ purchase_order_id +"/purchase_order_products/add?product_ids="+ product_id +"&purchase_order_id="+ purchase_order_id +"&quantities=0",
                success: function(response) {
                    alert('Product successfully added to file.')
                }
            });
        }

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