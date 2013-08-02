class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :suppliers

  belongs_to :unit

  validates :name, :price, :presence => true
  validates :price, numericality: { greater_than: 0 }
  validates :purchase_price, numericality: { greater_than: 0, allow_nil: true }
  validates :min_stock, :quantity_package, numericality: { only_integer: true, greater_than: 0, allow_nil: true }
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
    suggestions = where("code like ?", "%#{prefix}%")
    suggestions.limit(10).collect { |p| { :label => p.code, :value => p.code, :product => {:id => p.id, :code => p.code, :description => p.name, :unit_value => p.price, :purchase_price => p.purchase_price } } }
  end

  def self.terms_name_for(prefix)
    suggestions = where("name like ?", "%#{prefix}%")
    suggestions.limit(10).collect { |p| { :label => p.name, :value => p.name, :product => {:id => p.id, :code => p.code, :description => p.name, :unit_value => p.price, :purchase_price => p.purchase_price } } }
  end

end
