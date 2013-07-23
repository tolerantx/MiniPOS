class Ticket < ActiveRecord::Base

  has_one :recipient, dependent: :destroy

  has_many :items, dependent: :destroy

  belongs_to :customer

  validates :total, :presence => true
  validate :information_required

  accepts_nested_attributes_for :recipient
  accepts_nested_attributes_for :items, :allow_destroy => true

  default_scope { order(id: :desc) }

  before_validation :set_values

  attr_accessor :customer_id, :customer_name

  scope :search, ->(params) {
    conditions = []
    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "state like '%#{criteria}%'"
    end
    where conditions.join(" AND ")
  }

  state_machine :initial => :created do
    event :cancel do
      transition :created => :canceled
    end

    event :deliver do
      transition :created => :delivered
    end
  end

  def total_tickets
    items.collect().sum {|t| t.amount.to_f || 0.00 }
  end

  private

  def information_required
    errors.add(:base, I18n.t("errors.ticket.product_presence")) if self.items.size.eql?(0)
    # errors.add(:base, I18n.t("errors.ticket.customer_presence")) if self.customer_id.blank?
  end

  def set_values
    customer = Customer.find(self.customer_id)
    self.recipient = Recipient.new(:first_name => customer.first_name, :last_name => customer.last_name)
    self.recipient.address = Address.new(:address1 => customer.address.address1, :address2 => customer.address.address2, :zip_code => customer.address.zip_code, :state => customer.address.state, :city => customer.address.city, :town => customer.address.town, :location => customer.address.location)
    self.total = total_tickets
  end

end
