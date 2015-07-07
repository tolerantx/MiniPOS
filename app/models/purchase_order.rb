class PurchaseOrder < ActiveRecord::Base
  include ActiveRecord::General

  STATES = [%w[Creado created], %w[Recibido received], %w[Cancelado canceled]]

  has_many :items, as: :owner, dependent: :destroy

  belongs_to :supplier
  belongs_to :account

  validates :total, :presence => true

  accepts_nested_attributes_for :items, :allow_destroy => true

  default_scope { order(id: :desc) }

  before_validation :set_values

  scope :search, ->(params) {
    conditions = []

    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "suppliers.name like '%#{criteria}%'"
    end
    conditions << "suppliers.id = '#{params[:id]}'" if params && params[:id].present?
    conditions << "state = '#{params[:state]}'" if params && params[:state].present?

    if params && params[:start_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = (params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today) + 1
      conditions << "purchase_orders.created_at BETWEEN '#{start_date}' AND '#{end_date}'"
    end

    includes(:supplier).where(conditions.join(" AND ")).references(:supplier)
  }

  scope :by_account, -> (user) {
    where(account_id: user.account.id) if user.admin?
  }

  state_machine :initial => :created do
    event :cancel do
      transition :created => :canceled
    end

    event :receive do
      transition :created => :received
    end
  end

  def total_purchase_orders
    items.collect().sum {|t| t.amount.to_f || 0.00 }
  end

  private

  def information_required
    errors.add(:base, I18n.t("errors.purchase_order.product_presence")) if self.items.size.eql?(0)
  end

  def set_values
    self.total = total_purchase_orders
  end

end
