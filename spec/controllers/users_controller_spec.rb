require 'rails_helper'

describe UsersController, type: :controller do
  describe '#show' do
    let(:user) { create(:user) }
    before(:each) { get :show, id: user }

    it 'should render :show' do
      expect(response).to render_template(:show)
    end

    it 'should assign user comments to @comments' do
      comments = 5.times.collect { create(:comment, user: user) }

      expect(assigns(:comments)).to eq(comments)
    end

    it 'should assign requested User to @user' do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe '#new' do
    it 'should render :new' do
      get :new

      expect(response).to render_template(:new)
    end

    it 'should assign new User to @user' do
      get :new

      expect(assigns(:user)).to be_a_new(User)
    end
  end

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

      it 'should redirect to the login page' do
        post :create, user: data

        expect(response).to redirect_to signin_path
      end

      it 'should send a notice flash message' do
        post :create, user: data

        expect(flash[:notice]).to be_present
      end
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
