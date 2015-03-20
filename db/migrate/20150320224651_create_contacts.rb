class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.datetime :requested_at
      t.datetime :completed_at
      t.references :student

      t.timestamps null: false
    end
    add_column :students, :last_requested_help_at, :datetime

  end
end
