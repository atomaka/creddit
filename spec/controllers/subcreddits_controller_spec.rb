require 'rails_helper'

describe SubcredditsController, type: :controller do
  let!(:user) { build(:user) }
  let(:data) do
    {
      name: 'Testing Subcreddit 1'
    }
  end
  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  describe '#index' do
    let!(:subcreddits) { 3.times.collect { create(:subcreddit) } }

    it 'should render :index' do
      get :index

      expect(response).to render_template(:index)
    end

    it 'should assign all Subcreddits to @subcreddits' do
      get :index

      expect(assigns(:subcreddits)).to eq(subcreddits)
    end
  end

  describe '#show' do
    let!(:subcreddit) { create(:subcreddit) }
    let(:posts) { 5.times.collect { create(:post, subcreddit: subcreddit) } }
    before(:each) { get :show, id: subcreddit }

    it 'should render :show' do
      expect(response).to render_template(:show)
    end

    it 'should assign the Subcreddit to @subcreddit' do
      expect(assigns(:subcreddit)).to eq(subcreddit)
    end

    it 'should assign the post to show to @post' do
      expect(assigns(:posts)).to eq(posts)
    end
  end

  describe '#new' do
    it 'should render :new' do
      get :new

      expect(response).to render_template(:new)
    end

    it 'should assign new Subcreddit to @subcreddit' do
      get :new

      expect(assigns(:subcreddit)).to be_a_new(Subcreddit)
    end
  end

  describe '#create' do
    context 'with valid data' do
      it 'should create a subcreddit' do
        expect { post :create, subcreddit: data }
          .to change(Subcreddit, :count).by(1)
      end

      it 'should redirect to new subcreddit page index' do
        expect(post :create, subcreddit: data)
          .to redirect_to(assigns(:subcreddit))
      end

      it 'should send a notice flash message' do
        post :create, subcreddit: data

        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid data' do
      before(:each) { data['name'] = 'Bad name ' }

      it 'should not create a subcreddit' do
        expect { post :create, subcreddit: data }
          .to change(Subcreddit, :count).by(0)
      end

      it 'should render :new' do
        post :create, subcreddit: data

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    context 'with valid subcreddit' do
      context 'when owner' do
        let(:subcreddit) { create(:subcreddit, owner: user) }

        it 'should assign @subcreddit to the existing subcreddit' do
          get :edit, id: subcreddit

          expect(assigns(:subcreddit)).to eq(subcreddit)
        end

        it 'should render :edit' do
          get :edit, id: subcreddit

          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe '#update' do
    let(:data) do
      {
        closed: '1'
      }
    end

    context 'wth valid data' do
      context 'when owner' do
        let(:subcreddit) { create(:subcreddit, owner: user) }

        it 'should assign @subcreddit to the existing subcreddit' do
          put :update, id: subcreddit, subcreddit: data

          expect(assigns(:subcreddit)).to eq(subcreddit)
        end

        it 'should update the subcreddit' do
          put :update, id: subcreddit, subcreddit: data
          subcreddit.reload

          expect(subcreddit.closed_at).to_not eq(nil)
        end

        it 'should redirect to the subcreddit' do
          put :update, id: subcreddit, subcreddit: data

          expect(response).to redirect_to(subcreddit_url(subcreddit))
        end

        it 'should display a notice flash message' do
          put :update, id: subcreddit, subcreddit: data

          expect(flash[:notice]).to be_present
        end

        context 'with invalid data' do
          before(:each) { data[:closed] = 'bad' }

          it 'should render :edit' do
            put :update, id: subcreddit, subcreddit: data

            expect(response).to render_template(:edit)
          end
        end
      end
    end
  end
end
