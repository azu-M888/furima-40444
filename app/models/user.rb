class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates :password, presence: true,format: { with: VALID_PASSWORD_REGEX, message: 'は英字と数字の両方を含めて設定してください' }

    VALID_ZENKAKU_REGEX = /\A[ぁ-んァ-ン一-龥々]+\z/
    validates :last_name,presence: true, format: { with: VALID_ZENKAKU_REGEX, message: 'は全角で入力してください。' }
    validates :first_name,presence: true,format: { with: VALID_ZENKAKU_REGEX, message: 'は全角で入力してください。' }
    VALID_ZENKAKU_REGEX = /\A[ァ-ン]+\z/
    validates :first_name_kana,presence: true, format: { with: VALID_ZENKAKU_REGEX, message: 'は全角カナで入力してください。' }
    validates :last_name_kana,presence: true, format: { with: VALID_ZENKAKU_REGEX, message: 'は全角カナで入力してください。'  }

  validates :nickname, presence: true 
  validates :email, presence: true 
  validates :birth_date, presence: true

  # has_many :items, dependent: :destroy
  # has_many :orders,dependent: :destroy
end
