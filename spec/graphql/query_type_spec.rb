require 'rails_helper'

RSpec.describe 'QueryType', type: :graphql do
    query_string = <<-GQL
      query {
        account(userAccountNumber: "0090634999", bankCode: "044"){
          userAccountName
        }
      }
    GQL

    it "returns user account name from paystack if not available in DB" do
        result = BuycoinsChallenge1Schema.execute(query_string)
        returned_name = result.to_h['data']['account']['userAccountName']
        expect(returned_name).to eq 'Nobleheart Foundation'
    end

    it "returns user provided account name if available in DB" do
        user = User.find_or_create_by(name: 'Lorem Ipsum')
        account = Account.create(
          user_account_name: "Noblehearted Foundation",
          user_account_number: '0090634999', 
          bank_code: '044',
          user_id: user.id
        )

        result = BuycoinsChallenge1Schema.execute(query_string)
        returned_name = result.to_h['data']['account']['userAccountName']
        expect(returned_name).to eq 'Noblehearted Foundation'
    end

    it "returns error if account number cannot be resolved" do
        query_string = <<-GQL
            query {
                account(userAccountNumber: "009064999", bankCode: "044"){
                userAccountName
                }
            }
        GQL

        result = BuycoinsChallenge1Schema.execute(query_string)
        error_data = result.to_h['errors'][0]['message']
        expect(error_data).not_to be nil
    end
end