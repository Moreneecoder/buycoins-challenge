class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 20, minimum: 2 }, uniqueness: { case_sensitive: false }
    
    has_one :account
end
