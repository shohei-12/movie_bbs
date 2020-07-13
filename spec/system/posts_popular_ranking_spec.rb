require 'rails_helper'

RSpec.describe 'PostsPopularRanking', type: :system do
  before do
    @john = create(:john)
    @mary = create(:mary)
    @challenge = create(:challenge)
    @post_2_1 = create(:post_3, user_id: @john.id, category_id: @challenge.id)
    @post_2_2 = create(:post_3, user_id: @john.id, category_id: @challenge.id)
    @post_2_3 = create(:post_3, user_id: @mary.id, category_id: @challenge.id)
    create(:like, user_id: @john.id, post_id: @post_2_2.id)
    create(:like, user_id: @john.id, post_id: @post_2_3.id)
    create(:like, user_id: @mary.id, post_id: @post_2_3.id)
    visit posts_path
    click_link '人気ランキング'
    is_expected.to have_current_path posts_popular_path
    @posts = Post.joins(:likes).group(:post_id).order('count(post_id) desc')
  end

  subject { page }

  it 'display in order of the number of likes' do
    expect(@posts.length).to eq 2
    expect(@posts.first).to eq @post_2_3
    expect(@posts.second).to eq @post_2_2
    expect(@posts.include?(@post_2_1)).to eq false
    @posts.each do |post|
      is_expected.to have_link post.user.name, href: user_path(post.user)
      is_expected.to have_selector 'iframe'
      is_expected.to have_link post.category.name, href: "/posts/popular?category=#{post.category.id}"
      is_expected.to have_content post.content
    end
  end

  it 'display in order of the number of likes by category' do
    first('.jscroll li').click_link 'チャレンジ系'
    is_expected.to have_current_path "/posts/popular?category=#{@posts.first.category.id}"
    category = Category.find(@posts.first.category.id)
    posts_category = category.posts.joins(:likes).group(:post_id).order('count(post_id) desc')
    expect(posts_category.length).to eq 2
    expect(posts_category.first).to eq @post_2_3
    expect(posts_category.second).to eq @post_2_2
    expect(posts_category.include?(@post_2_1)).to eq false
    posts_category.each do |post|
      is_expected.to have_link post.user.name, href: user_path(post.user)
      is_expected.to have_selector 'iframe'
      is_expected.to have_link post.category.name, href: "/posts/popular?category=#{post.category.id}"
      is_expected.to have_content post.content
    end
  end
end
