# ====================================================================
# This global method calculate the total of the ticket
# ====================================================================
window.total_calculation = ->
  total = 0
  item_amounts = $('#items tr[style!="display: none;"], #purchase_order_details tr[style!="display: none;"]').find('input.product_amount')

  $.each(item_amounts, ->
    total += parseFloat(this.value) unless this.value is ""
  )
  $('span#total').text('$ ' + total.toFixed(2))

$ ->
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
  $('.product_code').livequery ->
    $(this).autocomplete
      source: "/products/search_code"
      autoFocus: true

      select: (event, ui) ->
        element = $(this).parents('tr')
        charge_product_information(element, ui.item.product)

  $('.product_description').livequery ->
    $(this).autocomplete
      source: "/products/search_name"
      autoFocus: true

      select: (event, ui) ->
        element = $(this).parents('tr')
        charge_product_information(element, ui.item.product)

  # ====================================================================
  # This method remove manually item of the form
  # ====================================================================
  $("#items tr.fields").livequery ->
    $(this).watch 'display', ->
      total_calculation()

  # ====================================================================
  # This methods set behavior of keys of the keyboard
  # ====================================================================
  $('body').keydown (e) ->
    keynum =  if (document.all) then e.keyCode else e.which

    # Add new item to the form with F2 key
    $('a.add_nested_fields').trigger('click') if keynum is 113

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
  # Charge product information to the html elements
  # ====================================================================
  charge_product_information = (el, product) ->
    $.each(product, (key, value) ->
      el.find('input.product_' + key).val(value)
      el.find('span.product_' + key).text(value)
    )
    $('.product_unit_value').trigger('change')
