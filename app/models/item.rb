class Item < ActiveRecord::Base
  belongs_to :ticket

  has_paper_trail
end
