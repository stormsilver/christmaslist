u = User.new(:email => 'ssilver@stormsilver.net', :password => 'christmas')
u.build_person first_name: 'Eric', last_name: 'Hankins', gender: :male
u.save!
