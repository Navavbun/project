users = 25.times.map do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email
  )
end

tags = 5.times.map do
  Tag.create!(
    name: Faker::Lorem.unique.word
  )
end

discussions = 10.times.map do
  d = Discussion.create!(
    topic: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 2),
  )

  tags.sample(rand(1..3)).each do |extra_tag|
    DiscussionTag.create!(discussion: d, tag: extra_tag)
  end

  d
end

20.times do
  Comment.create!(
    user: users.sample,
    discussion: discussions.sample,
    text: Faker::Lorem.sentence(word_count: 8)
  )
end
