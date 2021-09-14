class CreateEmos < ActiveRecord::Migration[5.2]
  def change
    create_table :emos do |t|
      t.text :emo_name
      t.timestamps
    end
  end
end
