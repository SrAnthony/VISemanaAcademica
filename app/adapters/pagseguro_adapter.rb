class PagseguroAdapter
  API_CHECKOUT = 'https://ws.pagseguro.uol.com.br/v2/checkout/'
  API_TRANSACTIONS = 'https://ws.pagseguro.uol.com.br/v2/transactions/'
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

    def payment_status(code)
      RestClient.get(API_TRANSACTIONS + code + "?email=#{EMAIL}&token=#{TOKEN}") do |response, request, result|
        if response.code == 200
          response_hash = Hash.from_xml(response.body).deep_symbolize_keys
          return { status: :ok, response: response_hash }
        end

        return { status: :error, response: response }
      end
    end

    def all_payments
      RestClient.get(API_TRANSACTIONS + "?email=#{EMAIL}&token=#{TOKEN}&initialDate=2018-11-01T00:00&finalDate=2018-11-16T00:00&page=1") do |response, request, result|
        if response.code == 200
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
