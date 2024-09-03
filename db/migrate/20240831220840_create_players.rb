class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :team
      t.string :position
      t.float :fantasy_pts_projected

      t.timestamps
    end
  end
end
