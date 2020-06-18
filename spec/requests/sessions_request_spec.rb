require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  before { @john = create(:john) }

  context 'when login information is correct' do
    it 'log in' do
      post login_path,
           params: { session: { email: @john.email, password: @john.password } }
      expect(is_logged_in?).to eq true
    end
  end

  context 'when login information is incorrect' do
    it 'not log in' do
      post login_path,
           params: { session: { email: 'john@example.co', password: 'pasword' } }
      expect(is_logged_in?).to eq false
    end
  end
end
