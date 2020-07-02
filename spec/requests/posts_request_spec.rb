require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:john) { create(:john) }
  let(:mary) { create(:mary) }

  subject { response }

  describe 'POST #create' do
    context 'when the user is not logged in' do
      it 'fail to post' do
        challenge = create(:challenge)
        post posts_path,
             params: { post: { url: 'TQ8WlA2GXbk', content: 'テスト投稿です', user_id: john.id, category_id: challenge.id } }
        is_expected.to redirect_to login_path
        expect(Post.count). to eq 0
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @post = create(:post_1, user_id: john.id)
    end

    context 'when the user is logged in' do
      context 'when the other user is logged in' do
        before do
          post login_path,
               params: { session: { email: mary.email, password: mary.password } }
        end

        it 'cannot delete a post' do
          delete post_path(@post)
          is_expected.to redirect_to user_path(mary)
        end
      end
    end

    context 'when the user is not logged in' do
      it 'cannot delete a post' do
        delete post_path(@post)
        is_expected.to redirect_to login_path
      end
    end
  end
end
