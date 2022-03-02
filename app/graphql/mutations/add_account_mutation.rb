# require 'faraday'
  require 'json'
  require 'levenshtein'

module Mutations
  class AddAccountMutation < BaseMutation
    # TODO: define return fields
    field :user, [Types::UserType]    
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

        check_ld_distance(name_from_paystack, user_account_number)
        # {
        #   user: account_object,
        #   errors: nil
        # }
      else
        {
          user: nil,
          errors: account_object[:message]
        }
      end

      # if account_object[:status] 
      #   name_from_paystack = account_object[:data][:account_name]

      #   if Levenshtein.distance(name_from_paystack, user_account_name) <= 2
      #     status = true
      #  else
      #     status = user_account_name == name_from_paystack
      #  end
      # else
      #   {
      #     error: account_object[:status]
      #   }
      # end

      # if status

      # user = User.find(user)
      # account = user.build_account(user_account_name: user_account_name, user_account_number: user_account_number, bank_code: bank_code)

      # if account.save
      #   {
      #     account: account
      #   }
      # else
      #   {
      #     account: nil,
      #     error: account.errors.full_messages
      #   }
      # end

      # else

      # end

    end
  end
end
