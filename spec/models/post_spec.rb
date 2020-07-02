require 'rails_helper'

RSpec.describe Post, type: :model do
  before { @post = create(:post_2) }

  describe 'url' do
    context 'when url is valid' do
      it 'return true' do
        expect(@post.valid?).to eq true
      end
    end

    context 'when url is invalid' do
      context 'when url is empty' do
        it 'return false' do
          @post.url = ''
          expect(@post.valid?).to eq false
        end
      end

      context 'when url is over 11 characters' do
        it 'return false' do
          @post.url = 'TQ8WlA2GXbka'
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
      context 'when content is over 800 characters' do
        it 'return false' do
          @post.content = 'a' * 801
          expect(@post.valid?).to eq false
        end
      end
    end
  end
end
