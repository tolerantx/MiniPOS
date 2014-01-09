namespace :management do
  desc "Creates main user"
  task :create_admin => :environment do
    User.create! do |u|
      u.email = 'user@domain.com'
      u.password = 'password123'
      u.password_confirmation = 'sistema1090'
    end
  end
end
