require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let(:john) { create(:john) }
  let(:mary) { create(:mary) }
  let(:guest) { create(:guest) }
  let(:relationship) { create(:relationship, user_id: john.id, follow_id: mary.id) }

  subject { response }

  context 'when the user is not logged in' do
    describe 'POST #create' do
      it 'cannot follow' do
        post relationships_path, params: { relationship: { follow_id: john.id } }
        is_expected.to redirect_to login_path
      end
    end

    describe 'DELETE #destroy' do
      it 'cannot unfollow' do
        delete relationship_path(relationship)
        is_expected.to redirect_to login_path
      end
    end
  end

  context 'when the user is logged in' do
    before do
      post login_path,
           params: { session: { email: guest.email, password: guest.password } }
    end

    describe 'POST #create' do
      context 'when following self' do
        it 'cannot follow' do
          post relationships_path, params: { relationship: { follow_id: guest.id } }
          is_expected.to redirect_to user_path(guest)
          expect(Relationship.count).to eq 0
        end
      end

      context 'when following a user who is already following' do
        before { create(:relationship, user_id: guest.id, follow_id: john.id) }

        it 'cannot follow' do
          post relationships_path, params: { relationship: { follow_id: john.id } }
        rescue StandardError
          expect(Relationship.count).to eq 1
        end
      end
    end

    describe 'DELETE #destroy' do
      context "when delete other user's follow relationship" do
        it 'cannot unfollow' do
          delete relationship_path(relationship)
        rescue StandardError
          expect(Relationship.count).to eq 1
        end
      end
    end
  end
end
