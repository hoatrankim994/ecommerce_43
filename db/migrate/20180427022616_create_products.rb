class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :productname
      t.integer :price
      t.integer :discount
      t.integer :onhand
      t.string :productcontent
      t.string :image
      t.integer :status
      t.timestamps
    end
  end
end
