json.extract! volunteer, :id, :first_name, :last_name, :grade_id, :email, :phone, :job_ids, :department_ids, :stand_ids, :created_at, :updated_at
json.url volunteer_url(volunteer, format: :json)
