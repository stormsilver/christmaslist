namespace :db do
  task :kill_connections => :environment do
    db_name = File.basename(Rails.root)
    sh = <<-BASH
    ps xa \
    | grep postgres: \
    | grep #{db_name} \
    | grep -v grep \
    | awk '{print $1}' \
    | xargs sudo kill
BASH
    puts `#{sh}`
  end
end

task "db:drop" => 'db:kill_connections'
