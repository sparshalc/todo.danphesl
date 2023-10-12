json.extract! todo, :id, :title, :description, :project_id, :created_at, :updated_at
json.url todo_url(todo, format: :json)
