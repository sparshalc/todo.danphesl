25.times do
  Project.create(
    title: Faker::Lorem.sentence(word_count: 5)
  )
end

project_ids = Project.pluck(:id)

50.times do
  Todo.create(
    title: Faker::Lorem.sentence(word_count: 5),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    project_id: project_ids.sample
  )
end