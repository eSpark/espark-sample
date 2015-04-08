class AddHelpRequestColumnsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :help_request_state, :boolean, default: false
    add_column :students, :help_last_requested, :datetime
  end
end
