# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Adding several users..."

def add_many_users(basename, god, how_many)
  (1..how_many).each do |num|
    puts "- Adding #{basename}#{num}"
    user = User.new
    user.username = "#{basename.downcase}#{num}"
    user.email = "#{basename.downcase}#{num}@gmail.com"
    user.password = "123456"
    user.password = "123456"
    user.capsules = 0
    user.active = true
    user.location = 'Paris France'
    user.gender = 1
    user.title = 'Il faillait un title en voila un !'
    user.save!
  end
end

add_many_users("Root", true, 5)
add_many_users("User", false, 10)
puts "Users are set !"
