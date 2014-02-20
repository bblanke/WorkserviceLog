class CreateTimecards < ActiveRecord::Migration
  def change
    create_table :timecards do |t|
      t.datetime :timein
      t.datetime :timeout
      t.integer :user_id

      t.timestamps
    end
  end
end
