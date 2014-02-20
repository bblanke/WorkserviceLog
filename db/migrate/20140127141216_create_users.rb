class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.float :t_hours, :default => 0
      t.float :week_hours, :default => 0
      t.string :password
      t.integer :service_id
      t.boolean :isadmin
      t.boolean :activecard

      t.timestamps
    end
  end
end
