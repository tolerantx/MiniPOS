class Email < ActiveRecord::Base
  TYPES = %w{Personal Trabajo Otro}

  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  belongs_to :owner, :polymorphic => true
end
