class RemoveColumnVisitsFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :visits, :integer
  end
end
