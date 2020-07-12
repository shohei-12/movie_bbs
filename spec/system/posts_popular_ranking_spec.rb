require 'rails_helper'

RSpec.describe 'PostsPopularRanking', type: :system do
  before do
    @john = create(:john)
    @mary = create(:mary)
    @post_2_1 = create(:post_1, user_id: @john.id)
    @post_2_2 = create(:post_1, user_id: @john.id)
    @post_2_3 = create(:post_1, user_id: @mary.id)
    create(:like, user_id: @john.id, post_id: @post_2_2.id)
    create(:like, user_id: @john.id, post_id: @post_2_3.id)
    create(:like, user_id: @mary.id, post_id: @post_2_3.id)
  end

  subject { page }

  it 'display in order of the number of likes' do
    visit posts_path
    click_link '人気ランキング'
    is_expected.to have_current_path posts_popular_path
    posts = Post.joins(:likes).group(:post_id).order('count(post_id) desc')
    expect(posts.length).to eq 2
    expect(posts.first).to eq @post_2_3
    expect(posts.second).to eq @post_2_2
    expect(posts.include?(@post_2_1)).to eq false
    posts.each do |post|
      is_expected.to have_link post.user.name, href: user_path(post.user)
      is_expected.to have_selector 'iframe'
      is_expected.to have_content post.category.name
      is_expected.to have_content post.content
    end
  end
end
