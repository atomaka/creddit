require 'rails_helper'

describe ApplicationController, type: :controller do
  let!(:user) { create(:user) }
  let!(:user_session) { create(:user_session, user: user) }

  describe '#logged_in?' do
    context 'when logged in' do
      before(:each) { request.cookies['user_session'] = user_session.key }

      it 'should return true' do
        expect(controller.send(:logged_in?)).to be(true)
      end
    end

    context 'when not logged in' do
      it 'should return false' do
        expect(controller.send(:logged_in?)).to be(false)
      end
    end
  end

  describe '#current_user' do
    context 'when logged in' do
      before(:each) { request.cookies['user_session'] = user_session.key }

      it 'should return the current user' do
        expect(controller.send(:current_user)).to eq(user)
      end
    end

    context 'when not logged in' do
      it 'should return nil' do
        expect(controller.send(:current_user)).to be_nil
      end
    end
  end

  describe '#current_session' do
    context 'when logged in' do
      before(:each) { request.cookies['user_session'] = user_session.key }

      it 'should return the curren session' do
        expect(controller.send(:current_session)).to eq(user_session)
      end
    end

    context 'when not logged in' do
      it 'should return nil' do
        expect(controller.send(:current_session)).to be_nil
      end
    end
  end
end
