class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :admin, null: false, foreign_key: {to_table: :admins}
      t.string :text
      t.string :color, default: "primary"
      t.string :icon, default: "bell"
      t.string :link
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
