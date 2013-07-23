class Ticket < ActiveRecord::Base
  # STATUS = %w{Activo Inactivo}

  has_many :items
  belongs_to :customer

  validates :total, :presence => true

  accepts_nested_attributes_for :items

  default_scope order(id: :desc)

  before_validation :calculate_items

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
    self.items.collect().sum {|t| t.amount.to_f || 0.00 }
  end

  private

  def calculate_items
    errors.add(:base, I18n.t("errors.ticket.product_presence")) if self.items.size.eql?(0)
    self.total = total_tickets
  end

end
