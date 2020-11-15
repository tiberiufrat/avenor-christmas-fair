class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :color
      t.datetime :start
      t.datetime :end
      t.boolean :all_day
      t.references :admin, null: false, foreign_key: {to_table: :admins}

      t.timestamps
    end
  end
end
