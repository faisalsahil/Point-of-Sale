$(document).ready(function() {
    $("#chosen-select").select2({
        theme: "bootstrap"
    });

    $("#chosen-select").on("select2:select", function (evt) {
        var data = $("#chosen-select").select2("data")[0].id;

        var arr    = data.split(':');
        var pro_id = arr[0];
        var text   = arr[1];
        var s_price= arr[2];
        var stock  = arr[3];
        var tot    = s_price * 1;
        // Append to order sheet
        if ( $('#pro_' + pro_id).length > 0 )
        {
            var orderItemTR = $('#pro_' + pro_id);
            var quantityInput = orderItemTR.find('input.order-item-quantity-input');
            quantityInput.val( parseInt(quantityInput.val()) + 1 );
            calculateTotalPriceofItem(orderItemTR);
            orderItemTR.prependTo('#added_products tbody');
        }
        else
        {
            var html = "<tr class='order-item-tr' id='pro_"+ pro_id +"'>" +
                "<td>" + pro_id +
                "<input name='order[order_products_attributes][][product_id]' type='hidden' value='" + pro_id + "'></td>" +
                "<td>" + text + "</td>" +
                "<td class='order-item-stock'>" + stock + "</td>" +
                "<input name='order[order_products_attributes][][unit_cost]' type='hidden' value='" + s_price + "'></td>" +
                "<td class='order-item-sale-price'>" + s_price + "</td>" +
                "<td><input class='order-item-quantity-input' name='order[order_products_attributes][][quantity]' id='quantity' type='text' value='1' style='width:30%' ></td>" +
                "<td class='order-item-total'>" + tot + "</td>" +
                "<td><a href='#' class='remove_item' ><span class='fa fa-close'></span></a></td>" +
                "</tr>";
            $('#added_products tbody').prepend(html);
        }

        $("#chosen-select").val('').trigger('change');
        calculateGrossAmountTotal();
    });

    $('#added_products').on("click", ".remove_item", function(){
        $(this).parents('tr').remove();
        calculateGrossAmountTotal();
    });

    $('#added_products').on("keyup", ".order-item-quantity-input", function(event) {
        var orderItemTR = $(this).parents('tr.order-item-tr');
        calculateTotalPriceofItem(orderItemTR);
    });

    $('#discount_percentage').on("keyup", function(event) {
        calculateNetAmount();
    });

    // $('#added_products').on("keypress", ".order-item-quantity-input", function(event) {
    //     return event.keyCode != 13;
    // });
});

function calculateTotalPriceofItem(orderItemTR) {
    var quantity = parseInt(orderItemTR.find('input.order-item-quantity-input').val()) || 0;
    var stock    = parseInt(orderItemTR.find('td.order-item-stock').text());
    if (quantity <= stock)
    {
        var salePrice = parseFloat(orderItemTR.find('td.order-item-sale-price').text());
        var totalPrice = quantity * salePrice;
        orderItemTR.find('td.order-item-total').text( totalPrice || 0 );
        calculateGrossAmountTotal();
    }else{
        orderItemTR.find('input.order-item-quantity-input').val(0);
        orderItemTR.find('td.order-item-total').text(0);
        alert('Not enough stock available.');
        calculateGrossAmountTotal();
    }
}

function calculateGrossAmountTotal() {
    var gross_total = 0;
    $("#added_products > tbody > tr").each(function( i ) {
        gross_total = gross_total + parseFloat($(this).find('td.order-item-total').text());
        $('.gross_amount').text(gross_total);
    });
    if($("#added_products > tbody > tr").length == 0){
        $('.gross_amount').text(0);
    }
    calculateNetAmount();
}

function calculateNetAmount() {
    var gross_amount   = $('.gross_amount').text();
    var disc_percentage= parseFloat($('#discount_percentage').val()) || 0;
    var disc_total     = (gross_amount * disc_percentage) / 100;
    var net_amount     = gross_amount - disc_total;
    $('#discount_amount').text(disc_total);
    $('#total_amount').text(net_amount);
    $('#net_amount').text(net_amount);
}