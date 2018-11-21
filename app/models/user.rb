# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  cpf                    :string
#  matricula              :string
#  category               :integer
#  transaction_code       :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :cpf, presence: true

  def name
    first_name + ' ' + last_name
  end

  def category_name
    case category
    when 1
      return 'Andrew S. Tanenbaum'
    when 2
      return 'Alan Turing'
    when 3
      return 'Ada Lovelace'
    end
    return '--- Sem categoria ---'
  end

  def category_image
    case category
    when 1
      return 'andrew_s_tanenbaum.jpg'
    when 2
      return 'alan_turing.jpg'
    when 3
      return 'ada_lovelace.jpg'
    end
  end

  def category_named_price
    case category
    when 1
      return 'R$ 0'
    when 2
      return 'R$ 15,00'
    when 3
      return 'R$ 25,00'
    end
  end

  def category_price
    case category
    when 1
      return '0'
    when 2
      return '15.00'
    when 3
      return '25.00'
    end
  end

  def category_color
    case category
    when 1
      return 'green'
    when 2
      return 'yellow'
    when 3
      return 'red'
    end
  end

  def category_needs_payment?
    category != 1
  end

  def payment_status
    payment = PagseguroAdapter.payment_status(transaction_code)
    return -1 if payment[:status] == :error

    payment[:response][:transaction][:status].to_i
  end

  # Membros da staff, com permissão para acessar a Dashboard
  def staff?
    email.in? %w[
      anthony.nadaletti@gmail.com
      anthony@uffs.cafe
      sabrina.moczulski@gmail.com
      andrewsaxx@gmail.com
      naomi.nfm@gmail.com
      oborgesrapha@gmail.com
    ]
  end
end
