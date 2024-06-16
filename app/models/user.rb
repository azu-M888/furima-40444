class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: {
     with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i,
     message: 'は英数字の混合である必要があります'
  },on: :create

  validates :nickname, presence: true 
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birth_date, presence: true

  has_many :items, dependent: :destroy
  has_many :orders,dependent: :destroy
end
