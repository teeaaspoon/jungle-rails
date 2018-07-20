class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :products, index: true, foreign_key: true
      t.references :users, index: true, foreign_key: true
      t.text :description
      t.integer :rating

      t.timestamps null: false
    end
  end
end
