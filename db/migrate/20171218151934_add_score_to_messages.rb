class AddScoreToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :sentiment_score, :float
  end
end
