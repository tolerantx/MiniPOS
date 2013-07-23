jQuery ->
  # $('#ticket-code').itemAutocomplete()

  $('.item_code').livequery ->
    $(this).autocomplete
      source: "/products/search_code"

      select: (event, ui) ->
        parent = $(this).parents('tr')

        $.each(ui.item.product, (key, value) ->
          parent.find('input.item_' + key).val(value)
          parent.find('span.item_' + key).text(value)
        )
        $('.item_quantity').trigger('change')

  $('.item_description').livequery ->
    $(this).autocomplete
      source: "/products/search_name"

      select: (event, ui) ->
        parent = $(this).parents('tr')

        $.each(ui.item.product, (key, value) ->
          parent.find('input.item_' + key).val(value)
          parent.find('span.item_' + key).text(value)
        )
        $('.item_quantity').trigger('change')

  $('.item_quantity, .item_unit_value').livequery ->
    $(this).change ->
      parent    = $(this).parents('tr')
      quantity  = parent.find('input.item_quantity').val()
      price     = parent.find('input.item_unit_value').val()

      amount = (quantity * price).toFixed(2)
      parent.find('input.item_amount').val(amount)
      parent.find('span.item_amount').text(amount)

      total_calculation()

  # ====================================================================
  # This methods remove manually item of the form
  # ====================================================================
  $('.remove_item').livequery ->
    $(this).click ->
      message = $(this).attr('data-message')
      if confirm(message)
        $(this).closest('.fields').remove()
        total_calculation()

      return false

  # ====================================================================
  # This methods calculate the total of the ticket
  # ====================================================================
  total_calculation = ->
    total = 0
    $.each($('input.item_amount'), ->
      total += parseFloat(this.value) unless this.value is ""
    )
    $('span#total').text('$ ' + total.toFixed(2))

  # ====================================================================
  # This methods allows to put only numbers and dot character in a text field
  # ====================================================================
  $('input[type=text][data-only-number]').livequery ->
    $(this).keypress (e) ->
      only_numbers(e)

  only_numbers = (e) ->
    keynum =  if (document.all) then e.keyCode else e.which

    if keynum is 8 or keynum is 0 or keynum is 13
      return true
    else if keynum < 46 or keynum > 58
      return false;

  # ====================================================================
  # This methods set behavior of keys of the keyboard
  # ====================================================================
  $('body').keypress (e) ->
    keynum =  if (document.all) then e.keyCode else e.which

    # Add new item to the form with F2 key
    $('a.add_nested_fields').trigger('click') if keynum is 124 #113


