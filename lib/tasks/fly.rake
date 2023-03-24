namespace :fly do
  task :ssh do
    sh 'fly ssh console -C "sudo -iu rails"'
  end

  task :console do
    sh 'fly ssh console -C "rails/bin/rails console"'
  end

  task :dbconsole do
    sh 'fly ssh console -C "rails/bin/rails dbconsole"'
  end

  task :dbreset do
    sh 'fly ssh console -C "rails/bin/rails db:migrate:reset"'
  end

  task :dbseed do
    sh 'fly ssh console -C "rails/bin/rails db:seed"'
  end

end