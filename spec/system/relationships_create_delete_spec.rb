require 'rails_helper'

RSpec.describe 'RelationshipsCreateDelete', type: :system do
  let(:john) { create(:john) }
  let(:mary) { create(:mary) }

  subject { page }

  context 'when the user is logged in' do
    before { log_in_as(john) }

    it 'can follow and unfollow other user' do
      visit user_path(mary)
      expect { click_button 'フォローする' }.to change(Relationship, :count).by(1)
      is_expected.to have_css '.success-message'
      expect { click_button 'フォローを解除する' }.to change(Relationship, :count).by(-1)
      is_expected.to have_css '.success-message'
      is_expected.to have_button 'フォローする'
    end
  end

  context 'when the user is not logged in' do
    it 'cannot follow and unfollow other user' do
      visit user_path(john)
      is_expected.not_to have_button 'フォローする'
      is_expected.not_to have_button 'フォローを解除する'
    end
  end
end
