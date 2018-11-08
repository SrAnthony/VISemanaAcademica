class PagseguroAdapter
  API_CHECKOUT = 'https://ws.pagseguro.uol.com.br/v2/checkout/'
  API_TRANSACTIONS = 'https://ws.pagseguro.uol.com.br/v3/transactions/'
  TOKEN = ENV['PAGSEGURO_TOKEN']
  EMAIL = ENV['PAGSEGURO_EMAIL']

  class << self
    def generate_payment_token(user)
      data = params(user)
      RestClient.post(API_CHECKOUT, data) do |response, request, result|
        if response.code == 200
          response_hash = Hash.from_xml(response.body).deep_symbolize_keys
          return { status: :ok, code: response_hash[:checkout][:code] }
        end

        return { status: :error }
      end
    end

    def payment_status(user)
      RestClient.get(API_TRANSACTIONS + user.transaction_code + "?email=#{EMAIL}&token=#{TOKEN}") do |response, request, result|
        if response.code == 20
          response_hash = Hash.from_xml(response.body).deep_symbolize_keys
          return { status: :ok, response: response_hash }
        end

        return { status: :error, response: response }
      end
    end

    private

    def params(user)
      {
        email: EMAIL,
        token: TOKEN,
        currency: 'BRL',
        itemId1: "000#{user.category}".to_i,
        itemDescription1: "Inscrição na VI Semana Acadêmica de CC - Categoria #{user.category_name}",
        itemAmount1: user.category_price,
        itemQuantity1: 1,
        senderEmail: user.email,
        senderName: user.name
      }
    end
  end
end
