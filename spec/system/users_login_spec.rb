require 'rails_helper'

RSpec.describe 'UsersLogin', type: :system do
  let(:john) { create(:john) }

  before { visit login_path }

  subject { page }

  context 'when login information is correct' do
    it 'log in' do
      fill_in 'メールアドレス', with: john.email
      fill_in 'パスワード', with: john.password
      click_button 'ログインする'
      is_expected.to have_current_path user_path(john)
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

  it 'log in as a guest user' do
    guest = create(:guest)
    click_link 'かんたんログイン'
    is_expected.to have_current_path user_path(guest)
    is_expected.to have_css '.success-message'
  end
end
