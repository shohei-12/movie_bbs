require 'rails_helper'

RSpec.describe 'UsersDetails', js: true, type: :system do
  before do
    @john = create(:john)
    create_list(:post_1, 30, user_id: @john.id)
  end

  subject { page }

  context 'when the user is logged in' do
    before { log_in_as(@john) }

    context 'when visit my details page' do
      it 'displayed correctly' do
        visit user_path(@john)
        execute_script('window.scroll(0,10000);')
        is_expected.to have_selector 'img[alt=プロフィール画像]'
        is_expected.to have_content @john.name
        is_expected.to have_link 'ユーザー情報を編集する', href: edit_user_path(@john)
        @john.posts.order(created_at: :desc).each do |post|
          is_expected.to have_content post.title
          is_expected.to have_content post.category.name
          is_expected.to have_content post.content
          is_expected.to have_link '削除する', href: post_path(post)
        end
      end
    end

    context 'when visit other users details page' do
      before do
        @mary = create(:mary)
        create_list(:post_1, 30, user_id: @mary.id)
      end

      it 'displayed correctly' do
        visit user_path(@mary)
        execute_script('window.scroll(0,10000);')
        is_expected.to have_selector 'img[alt=プロフィール画像]'
        is_expected.to have_content @mary.name
        is_expected.not_to have_link 'ユーザー情報を編集する', href: edit_user_path(@john)
        @mary.posts.order(created_at: :desc).each do |post|
          is_expected.to have_content post.title
          is_expected.to have_content post.category.name
          is_expected.to have_content post.content
          is_expected.not_to have_link '削除する', href: post_path(post)
        end
      end
    end
  end

  context 'when the user is not logged in' do
    it 'displayed correctly' do
      visit user_path(@john)
      execute_script('window.scroll(0,10000);')
      is_expected.to have_selector 'img[alt=プロフィール画像]'
      is_expected.to have_content @john.name
      is_expected.not_to have_link 'ユーザー情報を編集する', href: edit_user_path(@john)
      @john.posts.order(created_at: :desc).each do |post|
        is_expected.to have_content post.title
        is_expected.to have_content post.category.name
        is_expected.to have_content post.content
        is_expected.not_to have_link '削除する', href: post_path(post)
      end
    end
  end
end
