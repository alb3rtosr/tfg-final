json.extract! project, :id, :title, :description, :state, :created_at, :updated_at
json.url project_url(project, format: :json)
