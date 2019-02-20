class AddFieldsToVisits < ActiveRecord::Migration[5.2]
  def change
      
    drop_table :visits
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :short_url_id, null: false
      t.timestamps

    end
    
  end
end
