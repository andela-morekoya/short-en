class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :original
      t.string :slug
      t.integer :visits, :default => 0
      t.boolean :active, :default => true

      t.timestamps null: false
    end
  end
end
