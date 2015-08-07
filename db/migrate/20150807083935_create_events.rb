class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, index: true, null: false
      t.references :sport, index: true, foreign_key: true, null: false
    end
  end
end
