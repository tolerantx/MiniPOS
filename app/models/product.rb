class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :unit

  validates :name, :price, :presence => true
  validates :price, numericality: { greater_than: 0 }
  validates :min_stock, numericality: { only_integer: true, greater_than: 0, allow_nil: true }
  validates :max_stock, numericality: { only_integer: true, greater_than_or_equal_to: :min_stock, allow_nil: true }
  validates :existence, numericality: { allow_nil: true }

  default_scope { order(:name) }

  scope :search, ->(params) {
    conditions = []
    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "name like '%#{criteria}%'"
    end
    where conditions.join(" AND ")
  }

  def self.terms_code_for(prefix)
    suggestions = where("code like ?", "#{prefix}_%")
    suggestions.limit(10).collect { |p| { :label => p.code, :value => p.code, :product => {:code => p.code, :description => p.name, :unit_value => p.price } } }
  end
end
