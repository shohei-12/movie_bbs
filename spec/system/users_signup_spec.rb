require 'rails_helper'

RSpec.describe 'UsersSignup', type: :system do
  before { visit new_user_path }

  subject { page }

  context 'when user information is valid' do
    it 'add a user' do
      fill_in 'ユーザー名（50文字以内）', with: 'john'
      fill_in 'メールアドレス', with: 'john@example.com'
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      expect { click_button '登録する' }.to change(User, :count).by(1)
      is_expected.to have_current_path user_path(User.first)
      is_expected.to have_css '.success-message'
    end
  end

  context 'when user information is invalid' do
    it 'do not add a user' do
      fill_in 'ユーザー名（50文字以内）', with: ''
      fill_in 'メールアドレス', with: 'john@example'
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in '確認用パスワード', with: 'assword'
      expect { click_button '登録する' }.to change(User, :count).by(0)
      is_expected.to have_css '#error-messages'
    end
  end
end
