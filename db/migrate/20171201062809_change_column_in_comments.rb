class ChangeColumnInComments < ActiveRecord::Migration[5.1]
  def change
  	rename_column :comments, :desscription, :description
  end
end
