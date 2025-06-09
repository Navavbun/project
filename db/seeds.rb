tags = 20.times.map do
  Tag.create!(
    name: Faker::Lorem.unique.word
  )
end

discussions = 75.times.map do
  d = Discussion.create!(
    topic: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 2),
  )

  tags.sample(rand(1..3)).each do |extra_tag|
    DiscussionTag.create!(discussion: d, tag: extra_tag)
  end

  d
end
discussions.each do |discussion|
  45.times do
    Comment.create!(
      discussion: discussion,
      text: Faker::Lorem.sentence(word_count: 8)
    )
  end
end
