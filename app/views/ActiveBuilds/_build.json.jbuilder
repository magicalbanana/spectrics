json.extract! build, :id, :title, :text, :tags, :created_at, :updated_at
json.url activeBuild_url(build, format: :json)
