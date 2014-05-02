class Category < ActiveRecord::Base
  include ActiveRecord::General

  has_many :products

  belongs_to :account

  validates :name, :presence => true

  default_scope { order(:name) }

  scope :search, ->(params) {
    conditions = []
    terms = !params.nil? ? params[:terms] : ""
    terms.gsub(/[^a-zA-Z0-9\-Ññ\s]/, '').split(' ').each do |criteria|
      conditions << "name like '%#{criteria}%'"
    end
    where conditions.join(" AND ")
  }

end
