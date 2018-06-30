namespace :rubyflow do
  desc "Drop the database, create new, run migrations and insert initial data in the database"
  task :reset => :environment do |t|
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    Rake::Task["db:test:prepare"].invoke
  end
end
