class Customer < ActiveRecord::Base

  has_one :address, as: :owner, dependent: :destroy
  has_many :phones, as: :owner, dependent: :destroy
  has_many :emails, as: :owner, dependent: :destroy
  has_many :tickets

  validates :first_name, :last_name, :presence => true

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :phones, :allow_destroy => true
  accepts_nested_attributes_for :emails, :allow_destroy => true

  default_scope { order(:first_name, :last_name) }

  scope :search, ->(params) {
    conditions = []
    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "first_name like '%#{criteria}%' or last_name like '%#{criteria}%'"
    end
    where conditions.join(" AND ")
  }

  def self.terms_name_for(prefix)
    conditions = []
    prefix.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "first_name like '%#{criteria}%' or last_name like '%#{criteria}%'"
    end
    suggestions = where(conditions.join(" OR "))
    suggestions.limit(10).collect { |p| { :label => p.full_name, :value => p.full_name, :id => p.id, :customer => {:basic_address => p.basic_address} } }
  end

  def self.build_object
    new.tap do |customer|
      customer.address = Address.new
    end
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def basic_address
    [address.address1, address.address2].join(", ")
  end

end
