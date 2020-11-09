json.extract! event, :id, :title, :color, :start, :end, :all_day, :admin_id, :created_at, :updated_at
json.start event.start.iso8601
json.end event.end.iso8601
json.url event_url(event, format: :html)
