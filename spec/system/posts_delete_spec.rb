require 'rails_helper'

RSpec.describe 'PostsDelete', js: true, type: :system do
  before do
    @john = create(:john)
    @mary = create(:mary)
    @post = create(:post_1, user_id: @john.id)
  end

  subject { page }

  context 'when the user is logged in' do
    context 'when is logged in self' do
      before do
        log_in_as(@john)
        visit user_path(@john)
      end

      it 'delete a post' do
        accept_confirm { click_link '削除する' }
        is_expected.to have_current_path user_path(@john)
        is_expected.to have_css '.success-message'
        expect(Post.count).to eq 0
      end

      it 'do not delete a post' do
        dismiss_confirm { click_link '削除する' }
        is_expected.to have_current_path user_path(@john)
        expect(Post.count).to eq 1
      end
    end

    context 'when the other user is logged in' do
      before { log_in_as(@mary) }

      it 'cannot delete a post' do
        visit user_path(@john)
        is_expected.not_to have_link '削除する', href: post_path(@post)
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot delete a post' do
      visit user_path(@john)
      is_expected.not_to have_link '削除する', href: post_path(@post)
    end
  end
end
