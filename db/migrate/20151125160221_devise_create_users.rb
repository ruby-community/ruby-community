class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :github, null: false, index: { unique: true }

      t.timestamps null: false
    end
  end
end
