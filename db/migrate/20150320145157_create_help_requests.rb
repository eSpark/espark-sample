class CreateHelpRequests < ActiveRecord::Migration
  def change
    create_table :help_requests do |t|
      t.integer :student_id
      t.boolean :active

      t.timestamps null: false
    end
  end
end
