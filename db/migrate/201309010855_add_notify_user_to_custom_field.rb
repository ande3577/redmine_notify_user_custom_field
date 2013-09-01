class AddNotifyUserToCustomField < ActiveRecord::Migration
  def change
    add_column :custom_fields, :notify_user, :boolean, :default => false 
  end
end
