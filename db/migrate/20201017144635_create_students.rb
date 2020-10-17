class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.integer :balance
      t.string :first_name
      t.string :last_name
      t.references :grade, null: false, foreign_key: {to_table: :grades}

      t.timestamps
    end
  end
end
