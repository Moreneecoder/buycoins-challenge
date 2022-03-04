class RenameColumnsInAccounts < ActiveRecord::Migration[6.1]
  def change
    rename_column :accounts, :user_bank_name, :user_account_name
    rename_column :accounts, :user_bank_account, :user_account_number
  end
end
