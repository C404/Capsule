# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Create autistic admins
["lta@akr.fm", "champii@akr.fm", "grochophone@gmail.com",
 "enzo.finidori@gmail.com"].each do |admin|
  puts "Creating admin #{admin}"
  admin = AdminUser.create!(email: admin, password: "qweasd", password_confirmation: "qweasd")
end

# items = YAML.load_file [Rails.root, "db", "items.yml"].join("/")
# items.each do |item, data|
#   puts "Adding ItemType => #{item}: #{data['_desc']}"
#   Library::Category.create!(name: item, description: data['_desc'], root: true)
# end

15.times { puts "Creating category";FactoryGirl.create :library_root_category }
100.times { puts "Creating category";FactoryGirl.create :library_category }
500.times do
  puts "Creating item"
  item = FactoryGirl.create :library_item
end

# Events
rand(10).times do
  event = FactoryGirl.create :event

  # Trucks
  rand(5).times do
    truck = event.trucks.create(FactoryGirl.attributes_for(:truck))

    # Flights
    rand(20).times do
      flight = truck.flights.create(FactoryGirl.attributes_for(:flight))

      # Gears
      rand(5).times do 
        flight.gears << FactoryGirl.build(:gear, count: rand(5))
      end
    end
  end
end
