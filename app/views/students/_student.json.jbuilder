json.extract! student, :id, :balance, :first_name, :last_name, :grade_id, :created_at, :updated_at
json.url student_url(student, format: :json)
