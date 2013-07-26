module TicketsHelper
  def full_address(obj)
    address = obj.address1
    address += ", #{obj.address2}"
    address += ", #{obj.location}"
    address += ", #{obj.town}"
    address += ", #{obj.city}"
    address += ", #{obj.state}"
    address += ", C.P: #{obj.zip_code}"
  end

  def state_line(obj)
    states = { 'delivered' => 'success', 'canceled' => 'error' }
    states[obj.state]
  end

  def state_highlight(obj)
    states = { 'delivered' => 'btn-success', 'canceled' => 'btn-danger' }
    states[obj.state]
  end
end
