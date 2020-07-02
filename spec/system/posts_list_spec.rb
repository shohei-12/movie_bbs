require 'rails_helper'

RSpec.describe 'PostsList', js: true, type: :system do
  before do
    @john = create(:john)
    create_list(:post_1, 30, user_id: @john.id)
  end

  subject { page }

  it 'display all posts' do
    visit posts_path
    execute_script('window.scroll(0,10000);')
    Post.all.order(created_at: :desc).each do |post|
      is_expected.to have_link post.user.name, href: user_path(post.user)
      is_expected.to have_selector 'iframe'
      is_expected.to have_content post.category.name
      is_expected.to have_content post.content
    end
  end
end
