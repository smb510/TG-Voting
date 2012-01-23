class CreateRushes < ActiveRecord::Migration
  def change
    create_table :rushes do |t|
      t.string :name
      t.integer :mentions

      t.timestamps
    end
  end
end
