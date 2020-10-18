class CreateVolunteersJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs_volunteers do |t|
    	t.belongs_to :volunteer
    	t.belongs_to :job
    end
  end
end
