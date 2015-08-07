class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, index: true, null: false
      t.string :password, index: true, null: false
      t.references :role, index: true, foreign_key: true, null: false
    end
  end
end
