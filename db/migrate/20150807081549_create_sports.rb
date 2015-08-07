class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name, index: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
    end
  end
end
