# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed_user
  
  admin = User.where(user_id: "admin").first
  faculty = User.where(user_id: "faculty").first

  unless admin.present?
    admin =  User.new({:email => 'admin@test.com', :password => 'welcome', :user_id => 'admin', role: "admin"})
    admin.save!
  end
 
  unless faculty.present?
    faculty =  User.new({:email => 'faculty@ostryalabs.com', :password => 'welcome', :user_id => 'faculty', role: "faculty"})
    faculty.save!
  end
end

def seed_all
  seed_user
end

seed_all
