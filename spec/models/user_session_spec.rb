require 'rails_helper'

RSpec.describe UserSession, type: :model do
  describe '.active' do
    context 'with valid session' do
      let(:user_session) { create(:user_session) }

      context 'with correct key' do
        it 'should find the correct session' do
          expect(UserSession.authenticate(user_session.key)).to eq(user_session)
        end
      end

      context 'with invalid key' do
        it 'should not find a session' do
          expect(UserSession.authenticate('aaaaaa')).to be_nil
        end
      end
    end
  end

  describe '.new_by_user' do
    let(:user) { build(:user) }
    let(:env) do
      {
        'HTTP_USER_AGENT': 'Test User Agent',
        'REMOTE_ADDR': '192.168.1.1'
      }
    end

    context 'with valid user and environment' do
      let(:user_session) { UserSession.new_by_user(user, env) }

      it 'should create a new session' do
        # duplicated user_session creation for simplecov's benefit
        expect(UserSession.new_by_user(user, env)).to be_a(UserSession)
      end

      it 'should set the correct user' do
        expect(user_session.user).to eq(user)
      end

      it 'should set the correct user agent' do
        expect(user_session.user_agent).to eq(env['HTTP_USER_AGENT'])
      end

      it 'should set the correct IP address' do
        expect(user_session.ip).to eq(env['REMOTE_ADDR'])
      end
    end
  end
end
