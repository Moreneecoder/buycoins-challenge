module Types
  # $LOAD_PATH << '.'
  require_relative "../helpers/verify.rb"

  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    include Verify

    field :account, AccountType do
      description "Query that gets account name."

      argument :user_account_number, String, required: true
      argument :bank_code, String, required: true
    end

    field :errors, String

    def account(user_account_number:, bank_code:)

      account_object = Verify.bank_account(user_account_number, bank_code)
      raise(GraphQL::ExecutionError, account_object[:message]) unless account_object[:status]       

      name_from_paystack = account_object[:data][:account_name]
      account = Account.find_by(user_account_number: user_account_number)
 
      if account        
        {user_account_name: account.user_account_name.titleize}
      else
        {user_account_name: name_from_paystack.titleize}
      end

    end
  end
end
