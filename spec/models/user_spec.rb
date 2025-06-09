require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }

    describe 'first_name' do
      context 'when first_name is changed' do
        before { user.save! }

        it 'validates length between 2 and 35 characters' do
          user.last_name = 'Doe' # Set valid last_name for update validation
          user.first_name = 'J'
          expect(user).not_to be_valid
          expect(user.errors[:first_name]).to include('is too short (minimum is 2 characters)')

          user.first_name = 'a' * 36
          expect(user).not_to be_valid
          expect(user.errors[:first_name]).to include('is too long (maximum is 35 characters)')

          user.first_name = 'John'
          expect(user).to be_valid
        end

        it 'allows letters, spaces, hyphens and apostrophes' do
          user.last_name = 'Doe' # Set valid last_name for update validation
          valid_names = ['John', 'Jean-Pierre', "O'Connor", 'Mary Ann', 'José', 'François']
          valid_names.each do |name|
            user.first_name = name
            expect(user).to be_valid, "Expected '#{name}' to be valid"
          end
        end

        it 'does not allow numbers or special characters' do
          user.last_name = 'Doe' # Set valid last_name for update validation
          invalid_names = ['John123', 'John@', 'John!', 'John$']
          invalid_names.each do |name|
            user.first_name = name
            expect(user).not_to be_valid
            expect(user.errors[:first_name]).to include('is invalid')
          end
        end

        it 'does not allow empty first_name' do
          user.last_name = 'Doe' # Set valid last_name for update validation
          user.first_name = ''
          expect(user).not_to be_valid
          expect(user.errors[:first_name]).to include('is too short (minimum is 2 characters)')
        end
      end

      context 'on create' do
        it 'does not validate first_name' do
          user.first_name = ''
          expect(user.save).to be true
        end
      end
    end

    describe 'last_name' do
      context 'when last_name is changed' do
        before { user.save! }

        it 'validates length between 2 and 35 characters' do
          user.first_name = 'John' # Set valid first_name for update validation
          user.last_name = 'D'
          expect(user).not_to be_valid
          expect(user.errors[:last_name]).to include('is too short (minimum is 2 characters)')

          user.last_name = 'a' * 36
          expect(user).not_to be_valid
          expect(user.errors[:last_name]).to include('is too long (maximum is 35 characters)')

          user.last_name = 'Doe'
          expect(user).to be_valid
        end

        it 'allows letters, spaces, hyphens and apostrophes' do
          user.first_name = 'John' # Set valid first_name for update validation
          valid_names = ['Doe', 'Smith-Jones', "O'Brien", 'Van Der Berg', 'López']
          valid_names.each do |name|
            user.last_name = name
            expect(user).to be_valid, "Expected '#{name}' to be valid"
          end
        end

        it 'does not allow numbers or special characters' do
          user.first_name = 'John' # Set valid first_name for update validation
          invalid_names = ['Doe123', 'Doe@', 'Doe!', 'Doe$']
          invalid_names.each do |name|
            user.last_name = name
            expect(user).not_to be_valid
            expect(user.errors[:last_name]).to include('is invalid')
          end
        end

        it 'does not allow empty last_name' do
          user.first_name = 'John' # Set valid first_name for update validation
          user.last_name = ''
          expect(user).not_to be_valid
          expect(user.errors[:last_name]).to include('is too short (minimum is 2 characters)')
        end
      end

      context 'on create' do
        it 'does not validate last_name' do
          user.last_name = ''
          expect(user.save).to be true
        end
      end
    end

    describe 'login' do
      context 'on update' do
        before { user.save! }

        it 'must be unique (case insensitive)' do
          create(:user, login: 'johndoe')
          user.login = 'JOHNDOE'
          expect(user).not_to be_valid
          expect(user.errors[:login]).to include('has already been taken')
        end

        it 'validates length between 2 and 35 characters' do
          user.first_name = 'John' # Set valid first_name for update validation
          user.last_name = 'Doe' # Set valid last_name for update validation
          user.login = 'j'
          expect(user).not_to be_valid
          expect(user.errors[:login]).to include('is too short (minimum is 2 characters)')

          user.login = 'a' * 36
          expect(user).not_to be_valid
          expect(user.errors[:login]).to include('is too long (maximum is 35 characters)')

          user.login = 'johndoe'
          expect(user).to be_valid
        end

        it 'only allows letters, numbers, dots, underscores and hyphens' do
          user.first_name = 'John' # Set valid first_name for update validation
          user.last_name = 'Doe' # Set valid last_name for update validation
          valid_logins = ['johndoe', 'john.doe', 'john_doe', 'john-doe', 'john123', 'user.name-123']
          valid_logins.each do |login|
            user.login = login
            expect(user).to be_valid, "Expected '#{login}' to be valid"
          end

          invalid_logins = ['john@doe', 'john doe', 'john!', 'john#', 'john$doe']
          invalid_logins.each do |login|
            user.login = login
            expect(user).not_to be_valid
            expect(user.errors[:login]).to include('is invalid')
          end
        end
      end

      context 'on create' do
        it 'auto-generates login if blank' do
          user = build(:user, login: nil)
          user.save!
          expect(user.login).to match(/^user-\d{6}$/)
        end

        it 'does not change login if provided' do
          user = build(:user, login: 'customlogin')
          user.save!
          expect(user.login).to eq('customlogin')
        end

        it 'ensures generated login is unique' do
          # Create a user with specific login
          existing_user = create(:user)
          existing_login = existing_user.login

          # Mock Time to return same timestamp
          allow(Time).to receive(:current).and_return(Time.new(2024, 1, 1, 12, 0, 0))

          # Create new user - should generate different login
          new_user = build(:user, login: nil)
          new_user.save!

          expect(new_user.login).not_to eq(existing_login)
          expect(new_user.login).to match(/^user-\d{6}$/)
        end
      end
    end

    describe 'email' do
      it 'is required' do
        user.email = nil
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'must be unique (case insensitive)' do
        create(:user, email: 'test@example.com')
        user.email = 'TEST@EXAMPLE.COM'
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include('has already been taken')
      end

      it 'must be a valid email format' do
        invalid_emails = ['invalid.email', 'user@', '@example.com', 'user name@example.com']
        invalid_emails.each do |email|
          user.email = email
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include('is invalid')
        end
      end

      it 'accepts valid email addresses' do
        valid_emails = ['user@example.com', 'user.name@example.com', 'user+tag@example.co.uk']
        valid_emails.each do |email|
          user.email = email
          expect(user).to be_valid, "Expected '#{email}' to be valid"
        end
      end
    end
  end

  describe 'methods' do
    let(:user) { create(:user) }

    describe '#full_name' do
      it 'returns concatenated first and last name when both present' do
        user.update(first_name: 'John', last_name: 'Doe')
        expect(user.full_name).to eq('John Doe')
      end

      it 'returns "not specified" when first_name is blank' do
        user.update(first_name: '', last_name: 'Doe')
        expect(user.full_name).to eq('not specified')
      end

      it 'returns "not specified" when last_name is blank' do
        user.update(first_name: 'John', last_name: '')
        expect(user.full_name).to eq('not specified')
      end

      it 'returns "not specified" when both names are blank' do
        user.update(first_name: '', last_name: '')
        expect(user.full_name).to eq('not specified')
      end
    end

    describe '#full_name_present?' do
      it 'returns true when both first_name and last_name are present' do
        user.update(first_name: 'John', last_name: 'Doe')
        expect(user.full_name_present?).to be true
      end

      it 'returns false when first_name is blank' do
        user.update(first_name: '', last_name: 'Doe')
        expect(user.full_name_present?).to be false
      end

      it 'returns false when last_name is blank' do
        user.update(first_name: 'John', last_name: '')
        expect(user.full_name_present?).to be false
      end

      it 'returns false when both names are blank' do
        user.update(first_name: '', last_name: '')
        expect(user.full_name_present?).to be false
      end
    end
  end

  describe 'LoginGenerator concern' do
    it 'includes LoginGenerator module' do
      expect(User.ancestors).to include(LoginGenerator)
    end

    describe 'login generation' do
      it 'generates login in format user-XXXXXX on create' do
        user = build(:user, login: nil)
        user.save!
        expect(user.login).to match(/^user-\d{6}$/)
      end

      it 'does not regenerate login on update' do
        user = create(:user)
        original_login = user.login
        user.update!(first_name: 'Updated', last_name: 'User')
        expect(user.login).to eq(original_login)
      end
    end
  end

  describe 'devise modules' do
    it 'includes required devise modules' do
      expect(User.devise_modules).to include(
        :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :validatable
      )
    end
  end
end
