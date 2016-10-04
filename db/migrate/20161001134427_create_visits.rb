class CreateVisits < ActiveRecord::Migration
  def change
    drop_table :visits

    create_table :visits do |t|
      t.references :link, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :ip_address
      t.timestamps null: false
    end
  end
end
