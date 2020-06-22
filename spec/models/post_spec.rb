require 'rails_helper'

RSpec.describe Post, type: :model do
  before { @post = create(:post_2) }

  describe 'title' do
    context 'when title is valid' do
      it 'return true' do
        expect(@post.valid?).to eq true
      end
    end

    context 'when title is invalid' do
      context 'when title is empty' do
        it 'return false' do
          @post.title = ''
          expect(@post.valid?).to eq false
        end
      end

      context 'when title is over 50 characters' do
        it 'return false' do
          @post.title = 'a' * 51
          expect(@post.valid?).to eq false
        end
      end
    end
  end

  describe 'content' do
    context 'when content is valid' do
      it 'return true' do
        expect(@post.valid?).to eq true
      end
    end

    context 'when content is invalid' do
      context 'when content is empty' do
        it 'return false' do
          @post.content = ''
          expect(@post.valid?).to eq false
        end
      end

      context 'when content is over 800 characters' do
        it 'return false' do
          @post.content = 'a' * 801
          expect(@post.valid?).to eq false
        end
      end
    end
  end
end
