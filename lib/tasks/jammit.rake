namespace :jammit do
  task :package => :environment do
    require 'jammit'
    Sass::Plugin.update_stylesheets
    Jammit.package!
  end
end
