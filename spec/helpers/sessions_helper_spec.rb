require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe '#log_in(user)' do
    let(:john) { create(:john) }

    it 'return true' do
      expect(log_in(john)).to be_truthy
    end
  end
end
