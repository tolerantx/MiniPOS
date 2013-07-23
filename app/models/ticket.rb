class Ticket < ActiveRecord::Base

  has_many :items, dependent: :destroy
  belongs_to :customer

  validates :total, :presence => true
  validate :has_items?
  accepts_nested_attributes_for :items, :allow_destroy => true

  default_scope { order(id: :desc) }

  before_validation :set_values
  after_commit :update_values

  has_paper_trail

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

  def has_items?
    errors.add(:base, I18n.t("errors.ticket.product_presence")) if self.items.size.eql?(0)
  end

  def set_values
    self.total = total_tickets
  end

  def update_values
    self.update_attributes :total => total_tickets
  end

end
