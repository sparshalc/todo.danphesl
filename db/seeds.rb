10.times do
  Project.create(
    title: Faker::Lorem.sentence(word_count: 5),
    user_id: 1
  )
end

project_ids = Project.pluck(:id)

10.times do
  Todo.create(
    title: Faker::Lorem.sentence(word_count: 5),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    project_id: project_ids.sample,
    user_id: 1
  )
end