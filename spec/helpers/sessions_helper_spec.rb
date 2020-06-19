require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:john) { create(:john) }

  describe '#log_in(user)' do
    before { log_in(john) }

    it 'log in as john' do
      expect(session[:user_id]).to eq john.id
    end
  end

  describe '#logged_in?' do
    context 'when the user is logged in' do
      before { log_in(john) }

      it 'return true' do
        expect(logged_in?).to eq true
      end
    end

    context 'when the user is not logged in' do
      it 'return false' do
        expect(logged_in?).to eq false
      end
    end
  end

  describe '#current_user' do
    context 'when the user is logged in' do
      before { log_in(john) }

      it 'return the logged in user' do
        expect(current_user).to eq john
      end
    end

    context 'when the user is not logged in' do
      it 'return nil' do
        expect(current_user).to eq nil
      end
    end
  end

  describe '#current_user?(user)' do
    context 'when the given user is logged in' do
      before { log_in(john) }

      it 'return true' do
        expect(current_user?(john)).to eq true
      end
    end

    context 'when the given user is not logged in' do
      it 'return false' do
        expect(current_user?(john)).to eq false
      end
    end
  end

  describe '#log_out' do
    context 'when the user is logged in' do
      before { log_in(john) }

      it 'delete a session' do
        log_out
        expect(session[:user_id]).to eq nil
      end
    end

    context 'when the user is not logged in' do
      it 'return nil' do
        log_out
        expect(session[:user_id]).to eq nil
      end
    end
  end
end
