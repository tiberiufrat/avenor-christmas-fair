class CreateVolunteersDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments_volunteers do |t|
    	t.belongs_to :volunteer
    	t.belongs_to :department
    end
  end
end
