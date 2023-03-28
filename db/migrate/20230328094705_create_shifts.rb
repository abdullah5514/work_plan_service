class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :worker_id

      t.timestamps
    end
  end
end
