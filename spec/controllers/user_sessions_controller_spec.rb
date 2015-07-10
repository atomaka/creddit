require 'rails_helper'

describe UserSessionsController, type: :controller do
  describe '#new' do
    it 'should render :new' do
      get :new

      expect(response).to render_template(:new)
    end

    it 'should set a new Session to @session' do
      get :new

      expect(assigns(:user_session)).to be_a_new(UserSession)
    end
  end

  describe '#create' do
    let!(:user) { create(:user) }
    let(:data) do
      {
        username: user.username,
        password: user.password
      }
    end

    context 'with valid credentials' do
      it 'should create a user session' do
        expect do
          post :create,  user_session: data
        end.to change(UserSession, :count).by(1)
      end

      it 'should create a correct user_session cookie' do
        post :create, user_session: data

        expect(response.cookies['user_session']).to eq(UserSession.first.key)
      end

      it 'should redirect to the home page' do
        post :create, user_session: data

        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 'should not create a user session with a blank username' do
        data['username'] = ''

        expect do
          post :create, user_session: data
        end.to change(UserSession, :count).by(0)
      end

      it 'should not create a user session invalid credentials' do
        data['password'] = 'badpassword'

        expect do
          post :create, user_session: data
        end.to change(UserSession, :count).by(0)
      end

      it 'should render :new' do
        data['username'] = ''

        post :create, user_session: data

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#delete' do
    let!(:user) { create(:user) }
    let(:data) do
      {
        username: user.username,
        password: user.password
      }
    end

    context 'with a valid session' do
      let(:user_session) { create(:user_session) }

      it 'should delete the user_session cookie' do
        request.cookies['user_session'] = user_session.key

        delete :destroy

        expect(response.cookies['user_session']).to be_nil
      end

      it 'should delete the UserSession' do
        request.cookies['user_session'] = user_session.key
        allow_any_instance_of(ApplicationController)
          .to receive(:current_session).and_return(user_session)

        expect { delete :destroy }.to change(UserSession, :count).by(-1)
      end

      it 'should redirect to the root' do
        delete :destroy

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
