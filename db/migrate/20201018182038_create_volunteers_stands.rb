class CreateVolunteersStands < ActiveRecord::Migration[6.0]
  def change
    create_table :stands_volunteers do |t|
    	t.belongs_to :volunteer
    	t.belongs_to :stand
    end
  end
end
