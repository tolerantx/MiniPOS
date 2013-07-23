class Address < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true

  has_paper_trail
end
