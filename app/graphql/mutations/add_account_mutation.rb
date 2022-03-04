# require 'faraday'
  require 'json'
  require 'levenshtein'

module Mutations
  class AddAccountMutation < BaseMutation
    # TODO: define return fields
    # field :account, Types::AccountType
    field :user, Types::UserType    

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

      account_object = Verify.bank_account(user_account_number, bank_code)
      raise(GraphQL::ExecutionError, account_object[:message]) unless account_object[:status]
            
      name_from_paystack = account_object[:data][:account_name]

      lev_distance = Verify.lev_distance(name_from_paystack, user_account_name)
      raise(GraphQL::ExecutionError, "Could not resolve account name. Check parameters or try again.") unless lev_distance

      ActiveRecord::Base.transaction do   
        user = User.find(user)
        account = user.build_account(
          user_account_name: user_account_name,
          user_account_number: user_account_number, 
          bank_code: bank_code
        )

        raise(GraphQL::ExecutionError, account.errors.full_messages) unless account.save
        
        { user: user } if user.update!(is_verified: true)              
      end     
    end
  end
end
