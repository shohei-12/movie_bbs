require 'rails_helper'

RSpec.describe 'Users', type: :request do
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
        expect(response).to redirect_to root_path
        expect(User.count). to eq 2
      end
    end
  end
end
