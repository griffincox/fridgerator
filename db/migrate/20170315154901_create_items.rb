class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.date :expiration_date
      t.integer :location
      t.string :image_url
      t.integer :user_id

      t.timestamps

    end
  end
end
