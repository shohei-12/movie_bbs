require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = create(:john) }

  describe 'name' do
    context 'when name is valid' do
      it 'return true' do
        expect(@user.valid?).to eq true
      end
    end

    context 'when name is invalid' do
      context 'when name is empty' do
        it 'return false' do
          @user.name = ''
          expect(@user.valid?).to eq false
        end
      end

      context 'when name is over 50 characters' do
        it 'return false' do
          @user.name = 'a' * 51
          expect(@user.valid?).to eq false
        end
      end
    end
  end

  describe 'email' do
    context 'when email is valid' do
      it 'return true' do
        ['user@example.com',
         'USER@foo.COM',
         'A_US-ER@foo.bar.org',
         'first.last@foo.jp',
         'alice+bob@baz.cn'].each do |valid_email|
           @user.email = valid_email
           expect(@user.valid?).to eq true
         end
      end
    end

    context 'when email is invalid' do
      context 'when email is empty' do
        it 'return false' do
          @user.email = ''
          expect(@user.valid?).to eq false
        end
      end

      context 'when email is over 255 characters' do
        it 'return false' do
          @user.email = 'a' * 244 + '@example.com'
          expect(@user.valid?).to eq false
        end
      end

      context 'when email is duplicated' do
        it 'return false' do
          @other_user = User.new(name: 'john2',
                                 email: 'john@example.com',
                                 password: 'password',
                                 password_confirmation: 'password')
          expect(@other_user.valid?).to eq false
        end
      end

      context 'when email is an invalid format' do
        it 'return false' do
          ['user@example,com',
           'user_at_foo.org',
           'user.name@example.',
           'foo@bar_baz.com',
           'foo@bar+baz.com',
           'foo@bar..com'].each do |invalid_email|
             @user.email = invalid_email
             expect(@user.valid?).to eq false
           end
        end
      end
    end
  end

  describe 'password' do
    context 'when password is valid' do
      it 'return true' do
        expect(@user.valid?).to eq true
      end
    end

    context 'when password is invalid' do
      context 'when password is empty' do
        it 'return false' do
          @user.password = ''
          @user.password_confirmation = ''
          expect(@user.valid?).to eq false
        end
      end

      context 'when password is less than 6 characters' do
        it 'return false' do
          @user.password = 'abcde'
          @user.password_confirmation = 'abcde'
          expect(@user.valid?).to eq false
        end
      end
    end
  end
end
