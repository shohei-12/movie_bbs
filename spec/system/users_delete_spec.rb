require 'rails_helper'

RSpec.describe 'UsersDelete', js: true, type: :system do
  before do
    @john = create(:john)
    @mary = create(:mary)
    create_list(:dummy, 3)
  end

  subject { page }

  context 'when current user is admin' do
    before do
      log_in_as(@john)
      visit users_path
      User.page(1).each do |user|
        is_expected.to have_link '削除する', href: user_path(user) unless user.admin?
      end
    end

    it 'delete a user' do
      accept_confirm { click_link '削除する', match: :first }
      is_expected.to have_current_path users_path
      expect(User.count).to eq 4
    end

    it 'do not delete a user' do
      dismiss_confirm { click_link '削除する', match: :first }
      is_expected.to have_current_path users_path
      expect(User.count).to eq 5
    end
  end

  context 'when current user is not admin' do
    it 'cannot delete a user' do
      log_in_as(@mary)
      visit users_path
      User.page(1).each do |user|
        is_expected.not_to have_link '削除する', href: user_path(user)
      end
    end
  end
end
