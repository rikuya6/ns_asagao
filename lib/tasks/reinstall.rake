namespace :db do

  desc 'DB reinstall'

  task reinstall: :environment do
    Rake::Task['tmp:clear'].invoke
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end
