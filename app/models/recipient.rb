class Recipient < ActiveRecord::Base
  has_one :address, as: :owner, dependent: :destroy
  belongs_to :ticket

  def full_name
    [self.first_name, self.last_name].join(", ")
  end
end
