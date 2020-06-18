require 'rails_helper'

RSpec.describe 'UsersDelete', js: true, type: :system do
  before do
    create(:john)
    create_list(:dummy, 3)
    visit users_path
    User.page(1).each do |user|
      is_expected.to have_link '削除する', href: user_path(user) unless user.admin?
    end
  end

  subject { page }

  it 'delete a user' do
    accept_confirm { click_link '削除する', match: :first }
    is_expected.to have_current_path users_path
    expect(User.count). to eq 3
  end

  it 'do not delete a user' do
    dismiss_confirm { click_link '削除する', match: :first }
    is_expected.to have_current_path users_path
    expect(User.count). to eq 4
  end
end
