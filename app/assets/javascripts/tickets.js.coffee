$ ->
  $('#items .product_quantity,
    #items .product_unit_value').livequery ->

    $(this).change ->
      parent    = $(this).parents('tr')
      quantity  = parent.find('input.product_quantity').val()
      price     = parent.find('input.product_unit_value').val()

      amount = (quantity * price).toFixed(2)
      parent.find('input.product_amount').val(amount)
      parent.find('span.product_amount').text(amount)

      window.total_calculation()

  $('#print_it').click (e) ->
    e.preventDefault()
    $('#print').jqprint()
