class Supplier < ActiveRecord::Base
  has_one :address, as: :owner, dependent: :destroy
  has_many :phones, as: :owner, dependent: :destroy
  has_many :emails, as: :owner, dependent: :destroy
  has_many :tickets
  has_and_belongs_to_many :products

  validates :name, :presence => true

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :phones, :allow_destroy => true
  accepts_nested_attributes_for :emails, :allow_destroy => true

  has_paper_trail

  default_scope { order(:name) }

  scope :search, ->(params) {
    conditions = []
    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "name like '%#{criteria}%'"
    end
    where conditions.join(" AND ")
  }

  def self.build_object
    new.tap do |customer|
      customer.address = Address.new
    end
  end

end
