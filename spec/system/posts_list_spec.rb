require 'rails_helper'

RSpec.describe 'PostsList', js: true, type: :system do
  before do
    @john = create(:john)
    create_list(:post_1, 30, user_id: @john.id)
    visit posts_path
  end

  subject { page }

  it 'display all posts' do
    execute_script('window.scrollTo(0, document.body.scrollHeight);')
    Post.all.order(created_at: :desc).each do |post|
      is_expected.to have_link post.user.name, href: user_path(post.user)
      is_expected.to have_selector 'iframe'
      is_expected.to have_link post.category.name, href: "/posts?category=#{post.category.id}"
      is_expected.to have_content post.content
    end
  end

  it 'display posts by category' do
    first('.jscroll li').click_link 'チャレンジ系'
    visit current_path
    execute_script('window.scrollTo(0, document.body.scrollHeight);')
    Post.all.order(created_at: :desc).each do |post|
      is_expected.to have_link post.user.name, href: user_path(post.user)
      is_expected.to have_selector 'iframe'
      is_expected.to have_link 'チャレンジ系', href: "/posts?category=#{post.category.id}"
      is_expected.to have_content post.content
    end
  end
end
