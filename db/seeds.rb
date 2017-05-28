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
  channel_name: "Doe Before Bro",
  stripe_token: "fakeasstoken"
})

if signup.save
  user    = signup.user
  channel = signup.channel

  10.times do |i|
    aired_at = i.weeks.ago.to_date
    episode = Fabricate(:episode, {
                channel:  channel,
                aired_at: aired_at,
                visible:  true
              })

    (aired_at..Date.today).each do |date|
      Fabricate(:play, {
        bucket:  date,
        episode: episode,
        total:   Random.rand(100)
      })
    end

    episode.update_play_count_cache
  end

  puts "==================================="
  puts "Login email: #{user.email}"
  puts "Login pass:  password"
  puts "==================================="
else
  puts "Failed to seed the database"
  puts signup.errors.to_h
end
