module Verify
    def Verify.bank_account(account_number, bank_code)     
        conn = Faraday.new(
          # Account Verification
          url: 'https://api.paystack.co',
          headers: {'authorization' => "Bearer #{ENV['PAYSTACK_SECRET']}"}
        )
  
        resp = conn.get("bank/resolve?account_number=#{account_number}&bank_code=#{bank_code}")
        p JSON.parse(resp.body, symbolize_names: true)      
    end

    def Verify.lev_distance(name1, name2)
      return true if Levenshtein.distance(name1.downcase, name2.downcase) <= 2           
      name1 == name2
    end
end