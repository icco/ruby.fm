# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

signup = Signup.new({
  email:        "john@example.com",
  password:     "password",
  full_name:    "John Doe",
  channel_name: "Doe Before Bro"
})

if signup.save
  puts "Login email: john@example.com"
  puts "Login pass:  password"
end
