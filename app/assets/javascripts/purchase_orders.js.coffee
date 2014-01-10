$ ->
  $('#purchase_order_details .product_quantity,
    #purchase_order_details .product_quantity_required,
    #purchase_order_details .product_unit_value').livequery ->

    $(this).change ->
      parent    = $(this).parents('tr')
      quantity  = parent.find('input.product_quantity_required').val()
      quantity  ||= parent.find('input.product_quantity').val()
      price     = parent.find('input.product_unit_value').val()
      quantity  = 0 if quantity is undefined
      price     = 0 if price is undefined

      amount = (quantity * price).toFixed(2)
      parent.find('input.product_amount').val(amount)
      parent.find('span.product_amount').text(amount)

      window.total_calculation()
