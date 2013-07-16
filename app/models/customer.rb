class Customer < ActiveRecord::Base

  has_one :address, as: :owner, dependent: :destroy
  has_many :phones, as: :owner, dependent: :destroy
  has_many :emails, as: :owner, dependent: :destroy

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

  def self.build_object
    new.tap do |customer|
      customer.address = Address.new
    end
  end

  def full_name
    [first_name, last_name].join(' ')
  end

end
