require 'rails_helper'

RSpec.describe 'UsersEdit', type: :system do
  before do
    @john = create(:john)
    visit edit_user_path(@john)
  end

  subject { page }

  context 'when user information is valid' do
    it 'update user information' do
      fill_in 'ユーザー名（50文字以内）', with: 'John'
      fill_in 'メールアドレス', with: 'john@gmail.com'
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_button '編集する'
      is_expected.to have_current_path user_path(@john)
      is_expected.to have_content 'John'
    end
  end

  context 'when user information is invalid' do
    it 're-render the edit page' do
      click_button '編集する'
      is_expected.to have_css '#error-messages'
    end
  end
end
