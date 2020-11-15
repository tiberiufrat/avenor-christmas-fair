json.extract! event, :id, :title, :color, :start, :end, :all_day, :admin_id, :created_at, :updated_at
json.start event.start.iso8601
json.end event.end.iso8601 if event.end
json.allDay event.all_day
json.url event_url(event, format: :html)

json.admin_id event.admin_id

json.update_url event_url(event, method: :patch)
json.edit_url edit_event_path(event)
