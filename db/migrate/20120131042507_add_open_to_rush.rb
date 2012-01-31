class AddOpenToRush < ActiveRecord::Migration
  def change
    add_column :rushes, :open, :boolean
  end
end
