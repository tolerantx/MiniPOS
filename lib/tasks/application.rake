namespace :app do
  desc "Runs all the neccessary task for a fresh installation"
  task :install => :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['app:initial_data'].execute
  end

  desc "Generates the initial data"
  task :initial_data => :environment do
    Rake::Task['management:create_admin'].execute
  end
end
