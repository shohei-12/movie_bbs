require 'rails_helper'

RSpec.describe 'UsersDetails', type: :system do
  before { @john = create(:john) }

  subject { page }

  context 'when access from the user list page' do
    before { visit users_path }

    it 'view user details page' do
      click_link 'john'
      is_expected.to have_current_path user_path(@john)
      is_expected.to have_content @john.name
    end
  end
end
