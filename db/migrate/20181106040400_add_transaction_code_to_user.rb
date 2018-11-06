class AddTransactionCodeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :transaction_code, :string
  end
end
