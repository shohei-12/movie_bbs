require 'rails_helper'

RSpec.describe 'UsersDetails', type: :system do
  before do
    @john = create(:john)
    create_list(:post_1, 30, user_id: @john.id)
  end

  subject { page }

  context 'when access from the user list page' do
    before { visit users_path }

    it 'display user details page' do
      click_link 'john'
      is_expected.to have_current_path user_path(@john)
      is_expected.to have_content @john.name
      Post.page(1).each do |post|
        is_expected.to have_content post.title
        is_expected.to have_content post.content
      end
      is_expected.to have_css '.pagination'
      click_link '2'
      Post.page(2).each do |post|
        is_expected.to have_content post.title
        is_expected.to have_content post.content
      end
    end
  end
end
