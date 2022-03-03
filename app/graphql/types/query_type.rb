module Types
  # $LOAD_PATH << '.'
  require_relative "../helpers/verify.rb"

  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    include Verify

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World!"
    # end

    field :account, Types::AccountType, null: false do
      description "Query that gets account name."

      argument :user_account_number, String, required: true
      argument :bank_code, String, required: true
    end

    def account(user_account_number:, bank_code:)

      Verify.do_something

      # account_object = verify_account(user_account_number, bank_code) 
      # account = Account.find_by(user_account_number: user_account_number)

      # unless account

      # end
    end
  end
end
