user = User.find(1)
entries = user.entries.take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  entries.each { |entry| entry.comments.create!(content: content, user_id: user.id) }
end