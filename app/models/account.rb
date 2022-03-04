class Account < ApplicationRecord
    validates :user_account_name, presence: true
    validates :user_account_number, presence: true, length: { maximum: 10, minimum: 10 }
    validates :bank_code, presence: true, length: { maximum: 3, minimum: 3 }

    belongs_to :user
end
