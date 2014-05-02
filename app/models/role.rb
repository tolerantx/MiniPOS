class Role < ActiveRecord::Base
  validate :name, presence: true
  validates :name, uniqueness: true

  has_many :users
end
