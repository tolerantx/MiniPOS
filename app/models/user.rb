class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  belongs_to :account

  def super_admin?
    role ? role.name.eql?('Super Admin') : false
  end

  def admin?
    role ? role.name.eql?('Admin') : false
  end

end
