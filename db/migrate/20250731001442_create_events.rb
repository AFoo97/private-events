class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :location
      t.datetime :date
      t.boolean :private
      t.integer :creator_id

      t.timestamps
    end
  end
end
