class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :customer_first_name
      t.string :customer_last_name
      t.string :customer_email
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
