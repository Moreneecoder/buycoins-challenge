require 'rails_helper'

RSpec.describe Mutations::AddAccountMutation, type: :graphql do
        describe '.resolve' do
            user = User.find_or_create_by(name: 'Lorem Ipsum')
            let(:num_of_accounts) { Account.count }

            query_string = <<-GQL
                  mutation {
                    addAccountMutation(input: {
                      user: #{user.id},
                      userAccountName: "Bello Morenikeij Fuad"
                      userAccountNumber: "2132540160"
                      bankCode: "033"
                    }){
                      user {
                        id,
                        isVerified
                      }
                    }
                  }
              GQL

            it "creates an account when user's bank account is resolved" do
                BuycoinsChallenge1Schema.execute(query_string)
                expect(Account.count).to eq 1
            end
            
            
              it "verifies user when user's bank account is resolved" do
                result = BuycoinsChallenge1Schema.execute(query_string)
                verified_status = result.to_h['data']['addAccountMutation']['user']['isVerified']
                expect(User.last.is_verified).to eq verified_status
              end
            
        end
end