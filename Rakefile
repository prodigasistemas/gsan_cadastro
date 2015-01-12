# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

Rake::Task.tasks.each do |t|
  if t.name.include?("db") && (t.name.include?("load") || t.name.include?("purge"))
    t.clear
    t.add_description("!!! Disabled in favor of enterprise design at Acme.")
  end
end if Rails.env.test?
