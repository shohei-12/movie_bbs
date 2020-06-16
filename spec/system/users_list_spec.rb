require 'rails_helper'

RSpec.describe 'UsersList', type: :system do
  before { create_list(:dummy, 30) }

  subject { page }

  it 'display user list page' do
    visit users_path
    is_expected.to have_current_path users_path
    User.page(1).each do |user|
      is_expected.to have_link user.name, href: user_path(user)
    end
    is_expected.to have_css '.pagination'
    click_link '2'
    User.page(2).each do |user|
      is_expected.to have_link user.name, href: user_path(user)
    end
  end
end
