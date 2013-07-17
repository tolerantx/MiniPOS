class Ticket < ActiveRecord::Base
  STATUS = %w{Activo Inactivo}

  has_many :items
  belongs_to :customer

  validates :total, :status, :presence => true
  validates :total, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :items

  default_scope order(id: :desc)

  scope :search, ->(params) {
    conditions = []
    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "status like '%#{criteria}%'"
    end
    where conditions.join(" AND ")
  }

end
