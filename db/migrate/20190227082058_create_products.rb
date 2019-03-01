class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :chemical
      t.integer :type

      t.timestamps
    end
  end
end