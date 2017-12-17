class AddPointsAndHotscoreToLink < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :points, :integer, default: 1
    add_column :links, :hot_score, :float, default: 0
  end
end
