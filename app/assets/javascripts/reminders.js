// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
    $('#product_purchase_order_id').on('change', function() {
        if($(this).val() != "")
        {
            $(this).next('input').prop('disabled', true);
        }
        else
        {
            $(this).next('input').prop('disabled', false);
        }

    });
});