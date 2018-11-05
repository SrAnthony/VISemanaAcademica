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

  def category_price
    case category
    when 1
      return 'GRATUITO'
    when 2
      return 'R$ 15,00'
    when 3
      return 'R$ 25,00'
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
end
