json.extract! notification, :id, :admin_id, :text, :color, :icon, :link, :created_at, :updated_at
json.url notification_url(notification, format: :json)
