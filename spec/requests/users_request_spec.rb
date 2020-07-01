require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject { response }

  describe 'POST #create' do
    it 'add a user' do
      post users_path,
           params: { user: { name: 'john', email: 'john@example.com', password: 'password', password_confirmation: 'password' } }
      expect(User.count).to eq 1
      is_expected.to redirect_to user_path(User.first)
      expect(is_logged_in?).to eq true
    end
  end

  describe 'DELETE #destroy' do
    before do
      @john = create(:john)
      @mary = create(:mary)
    end

    context 'when current user is not admin' do
      before do
        post login_path,
             params: { session: { email: @mary.email, password: @mary.password } }
      end

      it 'cannot delete a user' do
        delete user_path(@john)
        is_expected.to redirect_to root_path
        expect(User.count).to eq 2
      end
    end
  end
end
