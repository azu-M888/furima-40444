require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
      it 'nicknameが空では登録できない' do
        user = FactoryBot.build(:user) 
        user.nickname = '' 
        user.valid?
        expect(user.errors.full_messages).to include ("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        user = FactoryBot.build(:user)  
        user.email = '' 
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
        user = FactoryBot.build(:user) 
        user.password = '' 
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345' 
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)") 
      end
      it 'passwordは英字のみでは登録できない' do
        user = FactoryBot.build(:user)
        user.password = 'ABCDEF'
        user.valid?
        expect(user.errors.full_messages).to include("Password は英字と数字の両方を含めて設定してください")
      end
      it 'passwordは数字のみでは登録できない' do
        user = FactoryBot.build(:user)
        user.password = '123456'
        user.valid?
        expect(user.errors.full_messages).to include("Password は英字と数字の両方を含めて設定してください")
      end
      it 'passwordは全角文字を含むと登録できない' do
        user = FactoryBot.build(:user)
        user.password = '12国国AB'
        user.valid?
        expect(user.errors.full_messages).to include("Password は英字と数字の両方を含めて設定してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "first_name、last_name、first_name_kana、last_name_kanaが空では登録できない" do
        user = FactoryBot.build(:user)
        user.first_name = ''
        user.last_name = ''
        user.first_name_kana = ''
        user.last_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include ("First name can't be blank")
        expect(user.errors.full_messages).to include ("Last name can't be blank")
        expect(user.errors.full_messages).to include ("First name kana can't be blank")
        expect(user.errors.full_messages).to include ("Last name kana can't be blank")
      end
      it "first_name、last_nameは全角以外では登録できない" do
        user = FactoryBot.build(:user)
        user.first_name = '121356'
        user.last_name = '121356'
        user.valid?
        expect(user.errors.full_messages).to include ("First name は全角で入力してください。")
        expect(user.errors.full_messages).to include ("Last name は全角で入力してください。")
      end
      it "first_name_kana、last_name_kanaは全角カナ以外では登録できない" do
        user = FactoryBot.build(:user)
        user.first_name_kana = '12国国56'
        user.last_name_kana = '12国国56'
        user.valid?
        expect(user.errors.full_messages).to include ("First name kana は全角カナで入力してください。")
        expect(user.errors.full_messages).to include ("Last name kana は全角カナで入力してください。")
      end
      it "birth_dateが空では登録できない" do
        user = FactoryBot.build(:user, birth_date: nil)
        user.valid?
        expect(user.errors.full_messages).to include ("Birth date can't be blank")
      end
  end
end

