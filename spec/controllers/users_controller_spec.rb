require 'rails_helper'

describe UsersController, type: :controller do
  describe '#create' do
    let(:data) do
      {
        username: 'username',
        password: 'password',
        email: 'username@domain.com'
      }
    end

    context 'with valid data' do
      it 'should create a user' do
        expect { post :create, user: data }.to change(User, :count).by(1)
      end

      it 'should redirect to the login page'
    end

    context 'with invalid data' do
      it 'should not create a user with an invalid username' do
        data['username'] = ''

        expect { post :create, user: data }.to change(User, :count).by(0)
      end

      it 'should not create a user with an invalid password' do
        data['password'] = ''

        expect { post :create, user: data }.to change(User, :count).by(0)
      end

      it 'should not create a user with an invalid email' do
        data['email'] = ''

        expect { post :create, user: data }.to change(User, :count).by(0)
      end

      it 'should render :new' do
        data['username'] = ''

        post :create, user: data

        expect(response).to render_template(:new)
      end
    end
  end
end
