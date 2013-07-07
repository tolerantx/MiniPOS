class Customer < ActiveRecord::Base
  has_many :phones, as: :owner, dependent: :destroy

  validates :first_name, :last_name, :presence => true
end
