require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
      it 'nicknameが空では登録できない' do
        user = FactoryBot.build(:user)  # Userのインスタンス生成
        user.nickname = ''  # nicknameの値を空にする
        user.valid?
        expect(user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        user = FactoryBot.build(:user)  # Userのインスタンス生成
        user.email = ''  # emailの値を空にする
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        user = FactoryBot.build(:user)  # Userのインスタンス生成
        user.password = ''  # emailの値を空にする
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordはアルファベットと数字の混合である必要がある' do
        user = FactoryBot.build(:user)
        user.password = '123456' # 変数名を @user から user に修正
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '1234' # パスワードを5文字以下に設定
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)") # 期待するエラーメッセージを修正
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "first_nameとlast_nameが空では登録できない" do
        user = FactoryBot.build(:user, first_name: nil, last_name: nil)
        user.valid?
        expect(user.errors.full_messages).to include "First name can't be blank"
        expect(user.errors.full_messages).to include "Last name can't be blank"
      end
      it "first_nameとlast_nameは全角以外では登録できない" do
        user = FactoryBot.build(:user, first_name: nil, last_name: nil)
        user.first_name = '123456'
        user.last_name = '123456'
        user.valid?
        expect(user.errors.full_messages).to include "First name 姓と名は全角で入力してください。"
        expect(user.errors.full_messages).to include "Last name 姓と名は全角で入力してください。"
      end
      it "first_name_kanaとlast_name_kanaが空では登録できない" do
        user = FactoryBot.build(:user, first_name_kana: nil, last_name_kana: nil)
        user.valid?
        expect(user.errors.full_messages).to include "First name kana can't be blank"
        expect(user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it "first_name_kanaとlast_name_kanaは全角以外では登録できない" do
        user = FactoryBot.build(:user, first_name: nil, last_name: nil)
        user.first_name_kana = '123456'
        user.last_name_kana = '123456'
        user.valid?
        expect(user.errors.full_messages).to include "First name kana カナ入力は全角で入力してください。"
        expect(user.errors.full_messages).to include "Last name kana カナ入力は全角で入力してください。"
      end
      it "birth_dateが空では登録できない" do
        user = FactoryBot.build(:user, birth_date: nil)
        user.valid?
        expect(user.errors.full_messages).to include "Birth date can't be blank"
      end
  end
end

