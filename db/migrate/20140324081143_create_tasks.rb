class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :content
      t.integer :account_id

      t.timestamps
    end
  end
end