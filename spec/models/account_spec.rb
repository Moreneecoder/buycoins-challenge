require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user) { User.find_or_create_by(name: 'Lorem Ipsum') }
  let(:account) do
    user.build_account(
      user_account_name: "Lorem Ikechukwu Ipsum",
      user_account_number: "1234567890", 
      bank_code: "012"
    )
  end

  describe 'Validations' do
    describe 'user_account_name' do
        it 'must be present' do
          expect(account).to be_valid
  
          account.user_account_name = nil
          expect(account).to_not be_valid
        end
    end

    describe 'user_account_number' do
        it 'must be present' do
          expect(account).to be_valid
  
          account.user_account_number = nil
          expect(account).to_not be_valid
        end

        it 'must be exactly 10 characters' do
          expect(account).to be_valid
    
          account.user_account_number = "123456789"          
          expect(account).to_not be_valid

          account.user_account_number = "123456789012"          
          expect(account).to_not be_valid
        end
    end

    describe 'bank_code' do
        it 'must be present' do
          expect(account).to be_valid
  
          account.user_account_number = nil
          expect(account).to_not be_valid
        end

        it 'must be exactly 3 characters' do
          expect(account).to be_valid
    
          account.user_account_number = "12"          
          expect(account).to_not be_valid

          account.user_account_number = "1234"          
          expect(account).to_not be_valid
        end
    end
  end

  describe 'Associations' do
      it 'belongs to one user' do
          account = Account.reflect_on_association(:user)
          expect(account.macro).to eq(:belongs_to)
      end
  end
end