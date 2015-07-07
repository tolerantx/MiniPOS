namespace :management do
  desc "Creates main user"
  task :create_admin => :environment do
    role = Role.find_by_name('Super Admin')
    account = Account.create(name: 'Global')
    User.create! do |u|
      u.email                 = 'user@domain.com'
      u.password              = 'sistema1090'
      u.password_confirmation = 'sistema1090'
      u.role                  = role
      u.account               = account
    end
  end
end
