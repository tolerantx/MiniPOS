class Phone < ActiveRecord::Base
  TYPES = %W{Casa Celular Trabajo Nextel Otro}

  belongs_to :owner, polymorphic: true

  has_paper_trail
end
