class DropRubotoTables < ActiveRecord::Migration
  def change
    drop_table :ruboto_tables
  end
end
