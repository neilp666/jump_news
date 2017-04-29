class AddPointsAndHotscoreToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :points, :integer, default: 1
    add_column :links, :hot_score, :float, deafult: 0
  end
end
