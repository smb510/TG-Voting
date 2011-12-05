class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :position
      t.string :candidate1
      t.string :candidate2
      t.string :candidate3
      t.string :candidate4
      t.string :candidate5
      t.boolean :irv
      t.boolean :open

      t.timestamps
    end
  end
end
