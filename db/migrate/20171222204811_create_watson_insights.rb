class CreateWatsonInsights < ActiveRecord::Migration[5.1]
  def change
    create_table :watson_insights do |t|
      t.integer "user_id"
      t.json "insight"
      t.timestamps
    end
  end
end
