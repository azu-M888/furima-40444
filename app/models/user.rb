class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'passwordは英字と数字の両方を含めて設定してください' }

    VALID_ZENKAKU_REGEX = /\A[ぁ-んァ-ン一-龥々]+\z/
    validates :last_name, format: { with: VALID_ZENKAKU_REGEX, message: '姓と名は全角で入力してください。' }
    validates :first_name, format: { with: VALID_ZENKAKU_REGEX, message: '姓と名は全角で入力してください。' }
    validates :first_name_kana, format: { with: VALID_ZENKAKU_REGEX, message: 'カナ入力は全角で入力してください。' }
    validates :last_name_kana, format: { with: VALID_ZENKAKU_REGEX, message: 'カナ入力は全角で入力してください。'  }

  validates :nickname, presence: true 
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birth_date, presence: true

  has_many :items, dependent: :destroy
  has_many :orders,dependent: :destroy
end
