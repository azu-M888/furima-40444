class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

CONSTANTS = {
  password_regex: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze,
  zenkaku_regex: /\A[ぁ-んァ-ン一-龥々]+\z/,
  zenkaku_kana_regex: /\A[ァ-ン]+\z/,
}

with_options presence: true do
  validates :nickname
  validates :birth_date
  validates :password, format: { with: CONSTANTS[:password_regex], message: 'は英字と数字の両方を含めて設定してください' }
  validates :last_name, format: { with: CONSTANTS[:zenkaku_regex], message: 'は全角で入力してください。' }
  validates :first_name, format: { with: CONSTANTS[:zenkaku_regex], message: 'は全角で入力してください。' }
  validates :first_name_kana, format: { with: CONSTANTS[:zenkaku_kana_regex], message: 'は全角カナで入力してください。' }
  validates :last_name_kana, format: { with: CONSTANTS[:zenkaku_kana_regex], message: 'は全角カナで入力してください。' }
end

  validates :nickname, presence: true 
  validates :birth_date, presence: true

  # has_many :items, dependent: :destroy
  # has_many :orders,dependent: :destroy
end
