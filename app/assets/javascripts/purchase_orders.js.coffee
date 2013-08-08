jQuery ->
  # ====================================================================
  # This block is to charge again when down no load turbolinks the DOM
  # ====================================================================
  ready = ->
    $("#purchase_order_details tr.fields").livequery ->
      $(this).watch 'display', ->
        total_calculation()

  $(document).ready(ready)
  $(document).on('page:load', ready)

  # ====================================================================
  # Search code and description of the products
  # ====================================================================
  $('.detail_code').livequery ->
    $(this).autocomplete
      source: "/products/search_code"

      select: (event, ui) ->
        parent = $(this).parents('tr')

        $.each(ui.item.product, (key, value) ->
          parent.find('input.detail_' + key).val(value)
          parent.find('span.detail_' + key).text(value)
        )
        $('.detail_quantity_required').trigger('change')

  $('.detail_description').livequery ->
    $(this).autocomplete
      source: "/products/search_name"

      select: (event, ui) ->
        parent = $(this).parents('tr')

        $.each(ui.item.product, (key, value) ->
          parent.find('input.detail_' + key).val(value)
          parent.find('span.detail_' + key).text(value)
        )
        $('.detail_quantity').trigger('change')

  $('.detail_quantity, .detail_quantity_required, .detail_purchase_price').livequery ->
    $(this).change ->
      parent    = $(this).parents('tr')
      quantity  = parent.find('input.detail_quantity_required').val()
      quantity  ||= parent.find('input.detail_quantity').val()
      price     = parent.find('input.detail_purchase_price').val()
      quantity  = 0 if quantity is undefined
      price     = 0 if price is undefined

      amount = (quantity * price).toFixed(2)
      parent.find('input.detail_amount').val(amount)
      parent.find('span.detail_amount').text(amount)

      total_calculation()

  # ====================================================================
  # This methods remove manually item of the form
  # ====================================================================
  $("#purchase_order_details tr.fields").livequery ->
    $(this).watch 'display', ->
      total_calculation()

  # ====================================================================
  # This methods calculate the total of the ticket
  # ====================================================================
  total_calculation = ->
    total = 0
    detail_amounts = $('#purchase_order_details tr[style!="display: none;"]').find('input.detail_amount')

    $.each(detail_amounts, ->
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