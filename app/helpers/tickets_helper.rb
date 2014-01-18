module TicketsHelper
  def full_address(obj)
    address = []
    address << obj.address1 unless obj.address1.blank?
    address << "#{obj.address2}" unless obj.address2.blank?
    address << "#{obj.location}" unless obj.location.blank?
    address << "#{obj.town}" unless obj.town.blank?
    address << "#{obj.city}" unless obj.city.blank?
    address << "#{obj.state}" unless obj.state.blank?
    address << "C.P: #{obj.zip_code}" unless obj.zip_code.blank?
    address.join(", ")
  end

  def state_line(obj)
    states = { 'delivered' => 'success', 'canceled' => 'error' }
    states[obj.state]
  end

  def state_highlight(obj)
    states = { 'delivered' => 'btn-success', 'canceled' => 'btn-danger', 'received' => 'btn-success' }
    states[obj.state]
  end
end
