namespace :management do
  desc "Creates main user"
  task :create_admin => :environment do
    role = Role.find_by_name('Super Admin')
    User.create! do |u|
      u.email                 = 'user@domain.com'
      u.password              = 'password123'
      u.password_confirmation = 'sistema1090'
      u.role                  = role
    end
  end
end
