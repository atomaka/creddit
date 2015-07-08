require 'rails_helper'

describe User, type: :model do
  let(:user) { build(:user) }

  it { should have_secure_password }

  context 'with valid data' do
    it 'should be valid' do
      expect(user).to be_valid
    end
  end

  context 'with invalid data' do
    it 'should not allow a blank username' do
      user.username = ''
      expect(user).to be_invalid
    end

    it 'should not allow duplicate usernames' do
      original = create(:user)
      duplicate = build(:user, username: original.username)
      expect(duplicate).to be_invalid
    end

    it 'should not allow blank emails' do
      user.email = ''
      expect(user).to be_invalid
    end

    it 'should downcase emails' do
      user.email = 'UPPERCASE@BADMAIL.COM'
      user.save
      expect(user.email).to eq('uppercase@badmail.com')
    end

    it 'should not allow duplicate emails' do
      original = create(:user)
      duplicate = build(:user, email: original.email)
      expect(duplicate).to be_invalid
    end

    it 'should not allow short passwords' do
      user.password = 'a' * 4
      expect(user).to be_invalid
    end
  end
end
