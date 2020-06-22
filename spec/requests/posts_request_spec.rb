require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'POST #create' do
    before { @john = create(:john) }

    context 'when the user is not logged in' do
      it 'fail to post' do
        post posts_path,
             params: { post: { title: 'テスト', content: 'テスト投稿です', user_id: @john.id } }
        expect(response).to redirect_to login_path
        expect(Post.count). to eq 0
      end
    end
  end
end
