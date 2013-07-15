class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :unit

  validates :name, :price, :presence => true
  validates :price, numericality: { greater_than: 0 }
  validates :min_stock, numericality: { only_integer: true, greater_than: 0 }
  validates :max_stock, numericality: { only_integer: true, greater_than_or_equal_to: :min_stock }

  default_scope { order("name ASC") }

  scope :search, proc { |params|
    conditions = []
    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "name like '%#{criteria}%'"
    end
    where conditions.join(" AND ")
  }
end
