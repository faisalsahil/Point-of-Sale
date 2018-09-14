$(document).ready(function() {
    $( "#cash_recieved" ).keyup(function() {
        if ($(this).val() == '' || $(this).val() == 0) {
            $('#remaining_balance').text('0');
        }
        else
        {
            var amount = parseFloat($('#net_amount').text());
            var cash = parseFloat($('#cash_recieved').val());
            $('#remaining_balance').text(cash - amount);
        
        }
    });
    // (function ($) {
    //     "use strict";
    //
    //     var Address = function (options) {
    //         this.init('editable', options, Address.defaults);
    //     };
    //
    //     $.fn.editableutils.inherit(Address, $.fn.editabletypes.abstractinput);
    //
    //     $.extend(Address.prototype, {
    //         render: function () {
    //             this.$input = this.$tpl.find('input');
    //         },
    //         activate: function () {
    //             this.$input.filter('[name="status"]').focus();
    //         }
    //     });
    //
    //     Address.defaults = $.extend({}, $.fn.editabletypes.abstractinput.defaults, {
    //         tpl: '<div class="editable-s"><label><span>Status: </span><input type="text" name="status" class="input-medium"></label></div>' +
    //         '<div class="editable-s"><label><span>Reason: </span><textarea rows="3" name="reason" class="input-medium"></textarea></label></div>',
    //
    //         inputclass: ''
    //     });
    //
    //     $.fn.editabletypes.address = Address;
    //
    // }(window.jQuery));

    $('.editable').editable({
        placement: 'right',
        ajaxOptions: {
            type: 'put',
            DataType: 'json'
        }
    });

    $("#chosen-select").select2({
        theme: "bootstrap"
    });

    $("#chosen-select").on("select2:select", function (evt) {
        var data = $("#chosen-select").select2("data")[0].id;
        console.log(data);
        var arr    = data.split(':');
        var pro_id = arr[0];
        var text   = arr[1];
        var s_price= arr[2];
        var stock  = arr[3];
        var p_price  = arr[4];
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
                "<td id = 'pro_id'>" + pro_id +
                "<input name='order[order_products_attributes][][product_id]' type='hidden' value='" + pro_id + "'>" +
                "<input name='order[order_products_attributes][][product_name]' type='hidden' value='" + text + "'>" +
                "<input name='order[order_products_attributes][][purchase_price]' type='hidden' value='" + p_price + "'></td>" +
                "<td>" + text + "</td>" +
                "<td class='order-item-stock'>" + stock + "</td>" +
                "<input name='order[order_products_attributes][][unit_cost]' type='hidden' value='" + s_price + "'>" +
                "<td class='order-item-sale-price'>" + s_price + "</td>" +
                "<td style='width:20%'><input class='order-item-quantity-input' name='order[order_products_attributes][][quantity]' id='quantity' type='text' value='1' style='width:85%' ></td>" +
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

// $(function(){
//     $('#save').on('submit', function(e){
//
//     });
// });

function calculateGrossAmountTotal() {
    var gross_total = 0;
    $("#added_products > tbody > tr").each(function( i ) {
        gross_total = parseFloat(gross_total) + parseFloat($(this).find('td.order-item-total').text());
        parseFloat($('#gross_amount').text(gross_total)).toFixed(2);
    });
    if($("#added_products > tbody > tr").length == 0){
        parseFloat($('#gross_amount').text(0)).toFixed(2);
    }
    calculateNetAmount();
}

function calculateNetAmount() {
    var gross_amount   = parseFloat($('#gross_amount').text()).toFixed(2);
    var disc_percentage= parseFloat($('#discount_percentage').val()).toFixed(2) || 0;
    var disc_total     = parseFloat((gross_amount * disc_percentage) / 100).toFixed(2);
    var net_amount     = parseFloat(gross_amount - disc_total).toFixed(2);
    parseFloat($('#discount_amount').text(disc_total)).toFixed(2);
    parseFloat($('#total_amount').text(net_amount)).toFixed(2);
    parseFloat($('#net_amount').text(net_amount)).toFixed(2);

    parseFloat($('#gross_amount1').text(gross_amount)).toFixed(2);
    parseFloat($('#discount_percentage1').text(disc_percentage)).toFixed(2);
    parseFloat($('#discount_amount1').text(disc_total)).toFixed(2);
    parseFloat($('#net_amount1').text(net_amount)).toFixed(2);
}