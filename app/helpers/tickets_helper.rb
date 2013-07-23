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
end
