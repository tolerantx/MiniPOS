jQuery ->
  # $('#ticket-code').itemAutocomplete()

  $('.item_code').livequery ->
    $(this).autocomplete
      source: "/products/search_code"
      change: (event, ui) ->

      select: (event, ui) ->
        parent = $(this).parents('tr')

        $.each(ui.item.product, (key, value) ->
          parent.find('input.item_' + key).val(value)
          parent.find('span.item_' + key).text(value)
        )
        $('.item_quantity').trigger('change')

  $('.item_quantity').livequery ->
    $(this).change ->
      parent    = $(this).parents('tr')
      quantity  = $(this).val()
      price     = parent.find('input.item_unit_value').val()

      amount = quantity * price
      parent.find('input.item_amount').val(amount)
      parent.find('span.item_amount').text(amount)

