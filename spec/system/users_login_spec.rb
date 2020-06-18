require 'rails_helper'

RSpec.describe 'UsersLogin', type: :system do
  before do
    @john = create(:john)
    visit login_path
  end

  subject { page }

  context 'when login information is correct' do
    it 'log in' do
      fill_in 'メールアドレス', with: @john.email
      fill_in 'パスワード', with: @john.password
      click_button 'ログインする'
      is_expected.to have_current_path user_path(@john)
      is_expected.to have_css '.success-message'
    end
  end

  context 'when login information is incorrect' do
    it 'not log in' do
      fill_in 'メールアドレス', with: 'john@example.co'
      fill_in 'パスワード', with: 'pasword'
      click_button 'ログインする'
      is_expected.to have_current_path login_path
      is_expected.to have_css '.danger-message'
    end
  end
end
