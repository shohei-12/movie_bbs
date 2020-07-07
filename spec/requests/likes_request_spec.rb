require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:mary) { create(:mary) }
  let(:john_post) { create(:post_2) }

  subject { response }

  context 'when the user is not logged in' do
    describe 'POST #create' do
      it 'cannot like' do
        post like_path(john_post.id), xhr: true
        is_expected.to redirect_to login_path
      end
    end

    describe 'DELETE #destroy' do
      it 'cannot unlike' do
        delete unlike_path(john_post.id), xhr: true
        is_expected.to redirect_to login_path
      end
    end
  end

  context 'when the user is logged in' do
    before do
      post login_path,
           params: { session: { email: mary.email, password: mary.password } }
    end

    context 'when like a post that already liked' do
      before { create(:like, user_id: mary.id, post_id: john_post.id) }

      it 'cannot like' do
        post like_path(john_post.id), xhr: true
      rescue StandardError
        expect(Like.count).to eq 1
      end
    end
  end
end
