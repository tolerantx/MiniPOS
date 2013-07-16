class Ticket < ActiveRecord::Base
  STATUS = %w{Activo Inactivo}
  belongs_to :customer

  validates :total, :status, :presence => true
  validates :total, numericality: { greater_than: 0 }

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
