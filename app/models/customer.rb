class Customer < ActiveRecord::Base

  has_one :address, as: :owner, dependent: :destroy
  has_many :phones, as: :owner, dependent: :destroy
  has_many :emails, as: :owner, dependent: :destroy

  validates :first_name, :last_name, :presence => true

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :phones, :allow_destroy => true
  accepts_nested_attributes_for :emails, :allow_destroy => true

  def self.build_object
    new.tap do |customer|
      customer.address = Address.new
    end
  end

end
