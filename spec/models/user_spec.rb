require 'rails_helper'

RSpec.describe User, type: :model do
  let(:john) { create(:john) }
  let(:mary) { create(:mary) }

  describe 'name' do
    context 'when name is valid' do
      it 'return true' do
        expect(john.valid?).to eq true
      end
    end

    context 'when name is invalid' do
      context 'when name is empty' do
        it 'return false' do
          john.name = ''
          expect(john.valid?).to eq false
        end
      end

      context 'when name is over 50 characters' do
        it 'return false' do
          john.name = 'a' * 51
          expect(john.valid?).to eq false
        end
      end
    end
  end

  describe 'email' do
    context 'when email is valid' do
      it 'return true' do
        ['user@example.com',
         'USER@foo.COM',
         'A_US-ER@foo.bar.org',
         'first.last@foo.jp',
         'alice+bob@baz.cn'].each do |valid_email|
          john.email = valid_email
          expect(john.valid?).to eq true
        end
      end
    end

    context 'when email is invalid' do
      context 'when email is empty' do
        it 'return false' do
          john.email = ''
          expect(john.valid?).to eq false
        end
      end

      context 'when email is over 255 characters' do
        it 'return false' do
          john.email = 'a' * 244 + '@example.com'
          expect(john.valid?).to eq false
        end
      end

      context 'when email is duplicated' do
        it 'return false' do
          create(:john)
          other_user = User.new(name: 'john2',
                                email: 'john@example.com',
                                password: 'password',
                                password_confirmation: 'password')
          expect(other_user.valid?).to eq false
        end
      end

      context 'when email is an invalid format' do
        it 'return false' do
          ['user@example,com',
           'user_at_foo.org',
           'user.name@example.',
           'foo@bar_baz.com',
           'foo@bar+baz.com',
           'foo@bar..com'].each do |invalid_email|
            john.email = invalid_email
            expect(john.valid?).to eq false
          end
        end
      end
    end
  end

  describe 'password' do
    context 'when password is valid' do
      it 'return true' do
        expect(john.valid?).to eq true
      end
    end

    context 'when password is invalid' do
      context 'when password is empty' do
        it 'return false' do
          john.password = ''
          john.password_confirmation = ''
          expect(john.valid?).to eq false
        end
      end

      context 'when password and confirmation password do not match' do
        it 'return false' do
          john.password_confirmation = 'foobar'
          expect(john.valid?).to eq false
        end
      end

      context 'when password is less than 6 characters' do
        it 'return false' do
          john.password = 'abcde'
          john.password_confirmation = 'abcde'
          expect(john.valid?).to eq false
        end
      end
    end
  end

  describe '#follow(other_user)' do
    context 'when following self' do
      it 'cannot follow' do
        expect(john.follow(john)).to eq nil
        expect(Relationship.count).to eq 0
      end
    end

    context 'when following other users' do
      it 'can follow' do
        expect(john.follow(mary)).to be_truthy
        expect(Relationship.count).to eq 1
      end
    end

    context 'when following a user who is already following' do
      before { john.follow(mary) }

      it 'cannot follow' do
        expect(john.follow(mary)).to eq false
      rescue StandardError
        expect(Relationship.count).to eq 1
      end
    end
  end

  describe '#unfollow(other_user)' do
    context 'when are following other user' do
      before { john.follow(mary) }

      it 'can unfollow' do
        expect(Relationship.count).to eq 1
        expect(john.unfollow(mary)).to be_truthy
        expect(Relationship.count).to eq 0
      end
    end

    context 'when are not following other user' do
      it 'cannot unfollow' do
        expect(john.unfollow(mary)).to eq nil
      end
    end
  end

  describe '#following?(other_user)' do
    context 'when are following a given user' do
      before { john.follow(mary) }

      it 'return true' do
        expect(john.following?(mary)).to eq true
      end
    end

    context 'when are not following a given user' do
      it 'return false' do
        expect(john.following?(mary)).to eq false
      end
    end
  end
end
