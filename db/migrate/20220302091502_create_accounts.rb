class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :user_bank_name, null: false
      t.string :user_bank_account, null: false
      t.string :bank_code, null: false

      t.timestamps
    end
  end
end
