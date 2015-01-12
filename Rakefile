# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

Rake::Task.tasks.each do |t|
  next if t.name[0,6] == "db:seed"
  if t.name[0,3] == "db:"
      t.clear
      t.add_description("!!! Disabled in favor of enterprise design at Acme.")
  end
end if Rails.env.test?
