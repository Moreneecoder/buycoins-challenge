class Account < ApplicationRecord
    validates :user_account_name, presence: true, length: { maximum: 100, minimum: 2 }
    validates :user_account_number, presence: true, length: { maximum: 10, minimum: 10 }
    validates :bank_code, presence: true

    belongs_to :user
end
