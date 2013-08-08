class PurchaseOrder < ActiveRecord::Base
  STATES = [%w[Creado created], %w[Recibido received], %w[Cancelado canceled]]

  has_many :items, as: :owner, dependent: :destroy

  belongs_to :supplier

  validates :total, :presence => true

  accepts_nested_attributes_for :items, :allow_destroy => true

  default_scope { order(id: :desc) }

  before_validation :set_values

  scope :search, ->(params) {
    conditions = []

    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "purchase_orders.id like '%#{criteria}%' or suppliers.name like '%#{criteria}%'"
    end
    conditions << "state = '#{params[:state]}'" if params && params[:state].present?

    includes(:supplier).where(conditions.join(" AND ")).references(:supplier)
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