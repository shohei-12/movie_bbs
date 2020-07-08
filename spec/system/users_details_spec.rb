require 'rails_helper'

RSpec.describe 'UsersDetails', js: true, type: :system do
  let(:john) { create(:john) }
  let(:mary) { create(:mary) }
  let(:category) { create(:challenge) }

  subject { page }

  context 'when the user is logged in' do
    before do
      log_in_as(john)
    end
    # JS doesn't work

    # context 'when visit my details page' do
    #   before do
    #     create_list(:post_3, 30, user_id: john.id, category_id: category.id)
    #     visit user_path(john)
    #   end

    #   it 'displayed correctly' do
    #     is_expected.to have_selector 'img[alt=プロフィール画像]'
    #     is_expected.to have_content john.name
    #     is_expected.to have_link 'ユーザー情報を編集する', href: edit_user_path(john)
    #     execute_script('window.scroll(0,10000);')
    #     john.posts.order(created_at: :desc).each do |post|
    #       is_expected.to have_selector 'iframe'
    #       is_expected.to have_link post.category.name, href: "/users/#{john.id}?category=#{post.category.id}"
    #       is_expected.to have_content post.content
    #       is_expected.to have_link '削除する', href: post_path(post)
    #     end
    #   end

    #   it 'display posts by category' do
    #     first('.jscroll li').click_link 'チャレンジ系'
    #     is_expected.to have_current_path "/users/#{john.id}?category=#{category.id}"
    #     execute_script('window.scroll(0,10000);')
    #     john.posts.where(category_id: category.id).order(created_at: :desc).each do |post|
    #       is_expected.to have_selector 'iframe'
    #       is_expected.to have_link post.category.name, href: "/users/#{john.id}?category=#{post.category.id}"
    #       is_expected.to have_content post.content
    #       is_expected.to have_link '削除する', href: post_path(post)
    #     end
    #   end
    # end

    context 'when visit other users details page' do
      before do
        create_list(:post_3, 30, user_id: mary.id, category_id: category.id)
        visit user_path(mary)
      end

      it 'displayed correctly' do
        is_expected.to have_selector 'img[alt=プロフィール画像]'
        is_expected.to have_content mary.name
        is_expected.not_to have_link 'ユーザー情報を編集する', href: edit_user_path(mary)
        execute_script('window.scroll(0,10000);')
        mary.posts.order(created_at: :desc).each do |post|
          is_expected.to have_selector 'iframe'
          is_expected.to have_link post.category.name, href: "/users/#{mary.id}?category=#{post.category.id}"
          is_expected.to have_content post.content
          is_expected.not_to have_link '削除する', href: post_path(post)
        end
      end

      it 'display posts by category' do
        first('.jscroll li').click_link 'チャレンジ系'
        is_expected.to have_current_path "/users/#{mary.id}?category=#{category.id}"
        execute_script('window.scroll(0,10000);')
        mary.posts.where(category_id: category.id).order(created_at: :desc).each do |post|
          is_expected.to have_selector 'iframe'
          is_expected.to have_link post.category.name, href: "/users/#{mary.id}?category=#{post.category.id}"
          is_expected.to have_content post.content
          is_expected.not_to have_link '削除する', href: post_path(post)
        end
      end
    end
  end

  context 'when the user is not logged in' do
    before do
      create_list(:post_3, 30, user_id: john.id, category_id: category.id)
      visit user_path(john)
    end

    it 'displayed correctly' do
      is_expected.to have_selector 'img[alt=プロフィール画像]'
      is_expected.to have_content john.name
      is_expected.not_to have_link 'ユーザー情報を編集する', href: edit_user_path(john)
      execute_script('window.scroll(0,10000);')
      john.posts.order(created_at: :desc).each do |post|
        is_expected.to have_selector 'iframe'
        is_expected.to have_link post.category.name, href: "/users/#{john.id}?category=#{post.category.id}"
        is_expected.to have_content post.content
        is_expected.not_to have_link '削除する', href: post_path(post)
      end
    end

    it 'display posts by category' do
      first('.jscroll li').click_link 'チャレンジ系'
      is_expected.to have_current_path "/users/#{john.id}?category=#{category.id}"
      execute_script('window.scroll(0,10000);')
      john.posts.where(category_id: category.id).order(created_at: :desc).each do |post|
        is_expected.to have_selector 'iframe'
        is_expected.to have_link post.category.name, href: "/users/#{john.id}?category=#{post.category.id}"
        is_expected.to have_content post.content
        is_expected.not_to have_link '削除する', href: post_path(post)
      end
    end
  end
end
