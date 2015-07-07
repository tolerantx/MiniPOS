class Ticket < ActiveRecord::Base
  include ActiveRecord::General

  STATES = [%w[Creado created], %w[Entregado delivered], %w[Cancelado canceled]]

  has_one :recipient, dependent: :destroy

  has_many :items, as: :owner, dependent: :destroy

  belongs_to :account

  validates :total, :presence => true
  validate :information_required

  accepts_nested_attributes_for :recipient
  accepts_nested_attributes_for :items, :allow_destroy => true

  default_scope { order(id: :desc) }

  before_validation :set_values
  after_update :update_stock

  attr_accessor :customer_id#, :customer_name

  scope :search, ->(params) {
    conditions = []

    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "recipients.first_name like '%#{criteria}%' or recipients.last_name like '%#{criteria}%'"
    end
    conditions << "tickets.id = '#{params[:id]}'" if params && params[:id].present?
    conditions << "state = '#{params[:state]}'" if params && params[:state].present?

    if params && params[:start_date]
      start_date = Date.parse(params[:start_date])
      end_date = params[:end_date].present? ? Date.parse(params[:end_date]) + 1 : Date.today + 1
      conditions << "tickets.created_at BETWEEN '#{start_date}' AND '#{end_date}'"
    end
    includes(:recipient).where(conditions.join(" AND ")).references(:recipient)
  }

  state_machine initial: :created do
    event :cancel do
      transition created: :canceled
    end

    event :deliver do
      transition created: :delivered
    end
  end

  def total_tickets
    items.collect().sum {|t| t.amount.to_f || 0.00 }
  end

  def folio
    "%07d" % id
  end

  private

  def information_required
    errors.add(:base, I18n.t("errors.ticket.product_presence")) if self.items.size.eql?(0)
    # errors.add(:base, I18n.t("errors.ticket.customer_presence")) if self.customer_id.blank?
  end

  def set_values
    if self.customer_id.present?
      customer                = Customer.find(self.customer_id)
      self.recipient          = Recipient.new(first_name: customer.first_name, last_name: customer.last_name, account_id: customer.account_id)
      self.recipient.address  = Address.new(address1: customer.address.address1, address2: customer.address.address2, zip_code: customer.address.zip_code, state: customer.address.state, city: customer.address.city, town: customer.address.town, location: customer.address.location)
      self.total              = total_tickets
    end
  end

  def update_stock
    self.items.each do |item|
      item.decrement_stock if self.delivered?
    end
  end

end
