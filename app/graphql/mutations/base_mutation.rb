require 'levenshtein'

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def verify_account(account_number, bank_code)     
      conn = Faraday.new(
        # Account Verification
        url: 'https://api.paystack.co',
        headers: {'authorization' => "Bearer #{ENV['PAYSTACK_SECRET']}"}
      )

      resp = conn.get("bank/resolve?account_number=#{account_number}&bank_code=#{bank_code}")
      p JSON.parse(resp.body, symbolize_names: true)      
    end

    def check_ld_distance(name1, name2)
      return true if Levenshtein.distance(name1.downcase, name2.downcase) <= 2           
      name1 == name2
    end
  end
end
