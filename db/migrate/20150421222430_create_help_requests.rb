class CreateHelpRequests < ActiveRecord::Migration
  def change
    create_table :help_requests do |t|
      t.integer :student_id
      t.string  :subject
    end
  end
end
