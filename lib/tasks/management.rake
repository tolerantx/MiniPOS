namespace :management do
  desc "Creates main user"
  task :create_admin => :environment do
    User.create! do |u|
      u.email = 'tolerantx@gmail.com'
      u.password = 'sistema1090'
      u.password_confirmation = 'sistema1090'
    end
  end
end
