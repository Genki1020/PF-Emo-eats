class CreateEateries < ActiveRecord::Migration[5.2]
  def change
    create_table :eateries do |t|
       t.integer :user_id
       t.integer :emo_id
       t.string :eatery_name
       t.string :image_id
       t.text :report
       t.string :address
       t.float :latitude
       t.float :longitude
       t.timestamps
    end
  end
end
