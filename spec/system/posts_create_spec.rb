require 'rails_helper'

RSpec.describe 'PostsCreate', type: :system do
  before do
    @john = create(:john)
    create(:challenge)
  end

  subject { page }

  context 'when the user is logged in' do
    before do
      log_in_as(@john)
      visit new_post_path
    end

    context 'when post information is valid' do
      it 'succeed in posting' do
        fill_in 'タイトル（50文字以内）', with: 'テスト'
        select 'チャレンジ系', from: 'カテゴリー選択'
        fill_in '内容（800文字以内）', with: 'テスト投稿です。'
        expect { click_button '投稿する' }.to change(Post, :count).by(1)
        is_expected.to have_current_path user_path(@john)
      end
    end

    context 'when post information is invalid' do
      it 'fail to post' do
        expect { click_button '投稿する' }.to change(Post, :count).by(0)
        is_expected.to have_css '#error-messages'
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot access the post page' do
      visit new_post_path
      is_expected.to have_current_path login_path
    end
  end
end
