class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :token
      t.string :payerid
      t.references :usuario, index: true, foreign_key: true
      t.decimal :total, precision: 10, scale: 3
      t.string :respuesta

      t.timestamps null: false
    end
  end
end
