require 'rails_helper'

RSpec.describe 'UsersLogout', type: :system do
  before do
    @john = create(:john)
    visit login_path
  end

  subject { page }

  it 'log out' do
    fill_in 'メールアドレス', with: @john.email
    fill_in 'パスワード', with: @john.password
    click_button 'ログインする'
    is_expected.to have_current_path user_path(@john)
    is_expected.to have_css '.success-message'
    click_link 'ログアウト'
    is_expected.to have_current_path root_path
    is_expected.to have_link 'ログイン', href: login_path
  end
end
