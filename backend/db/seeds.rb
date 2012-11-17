# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

1000.times do |i|
  content = Faker::Lorem.paragraph(1).split(' ').map{|w| rand(3)==0 ? "##{w}": w }.join(' ')

  puts "Adding fake capsule #{i}"
  puts "\t -> #{content}"
  Capsule.create!(content: content)
end

