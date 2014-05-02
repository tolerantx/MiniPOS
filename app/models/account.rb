class Account < ActiveRecord::Base
  has_many :users, dependent: :destroy

  validates :name, :presence => true

  accepts_nested_attributes_for :users, :allow_destroy => true
end
