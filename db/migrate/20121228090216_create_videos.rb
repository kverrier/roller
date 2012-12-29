class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :youtube_id
      t.integer :start_time
      t.integer :end_time

      t.timestamps
    end
  end
end
