# require 'faraday'
  require 'json'
  require 'levenshtein'

module Mutations
  class AddAccountMutation < BaseMutation
    # TODO: define return fields
    field :account, Types::AccountType
    field :user, Types::UserType
    field :errors, String

    # TODO: define arguments
    argument :user_account_name, String, required: true do
      description "User's bank account name as registered with bank. This field is required."
    end

    argument :user_account_number, String, required: true do
      description "User's bank account number. This field is required."
    end

    argument :bank_code, String, required: true do
      description "User's bank short code, eg: '058' for GTB. This field is required."
    end

    argument :user, Integer, required: true do
      description "Id of the user adding an account."
    end

    # TODO: define resolve method
    def resolve(user_account_name:, user_account_number:, bank_code:, user:)

      account_object = verify_account(user_account_number, bank_code) 
      
      if account_object[:status]
        name_from_paystack = account_object[:data][:account_name]

        if check_ld_distance(name_from_paystack, user_account_name)
          ActiveRecord::Base.transaction do   
            p user = User.find(user)
            account = user.build_account(user_account_name: user_account_name, user_account_number: user_account_number, bank_code: bank_code)

            { error: account.errors.full_messages } unless account.save!
            { user: user } if user.update!(is_verified: true)              
          end                          
        end

      else
        {
          user: nil,
          errors: account_object[:message]
        }
      end

    end
  end
end
