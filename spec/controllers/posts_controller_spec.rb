require 'rails_helper'

describe PostsController, type: :controller do
  let!(:user) { build(:user) }
  let!(:subcreddit) { create(:subcreddit) }
  let(:data) do
    {
      title: 'A New Post',
      content: 'Here is some content for that post'
    }
  end
  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  describe '#index' do
    let(:posts) { 10.times.collect { create(:post) } }
    before(:each) { get :index }

    it 'should render :index' do
      expect(response).to render_template(:index)
    end

    it 'should assign all Posts to @post' do
      posts.each do |post|
        expect(assigns(:posts)).to include(post)
      end
    end
  end

  describe '#show' do
    let(:post) { create(:post) }
    before(:each) { get :show, subcreddit_id: post.subcreddit, id: post }


    it 'should render :show' do
      expect(response).to render_template(:show)
    end

    it 'should assign correct Post to @post' do
      expect(assigns(:post)).to eq(post)
    end
  end

  describe '#new' do
    let(:post) { build(:post) }
    before(:each) { get :new, subcreddit_id: post.subcreddit }

    it 'should render :new' do
      expect(response).to render_template(:new)
    end

    it 'should assign new Post to @post' do
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe '#create' do

    context 'with valid data' do
      it 'should create a post' do
        expect { post :create, subcreddit_id: subcreddit, post: data }
          .to change(Post, :count).by(1)
      end

      it 'should redirect to the new post' do
        expect(post :create, subcreddit_id: subcreddit, post: data)
          .to redirect_to(subcreddit_post_path(assigns(:post).subcreddit,
                                               assigns(:post)))
      end

      it 'should send a notice flash message' do
        post :create, subcreddit_id: subcreddit, post: data

        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid data' do
      before(:each) { data['title'] = '' }

      it 'should not create a post' do
        expect { post :create, subcreddit_id: subcreddit, post: data }
          .to change(Post, :count).by(0)
      end

      it 'should render :new' do
        post :create, subcreddit_id: subcreddit, post: data

        expect(response).to render_template(:new)
      end
    end
  end

  context '#edit' do
    let!(:post) { create(:post) }
    before(:each) { get :edit, id: post, subcreddit_id: post.subcreddit }

    context 'with valid post' do
      it 'should render :edit' do
        expect(response).to render_template(:edit)
      end

      it 'should assign correct Post to @post' do
        expect(assigns(:post)).to eq(post)
      end
    end
  end

  context '#update' do
    let!(:post) { create(:post) }
    let(:data) do
      {
        title: 'New title',
        content: 'New content'
      }
    end

    context 'with valid data' do
      before(:each) do
        put :update, id: post, subcreddit_id: post.subcreddit, post: data
      end

      it 'should assign correct Post to @post' do
        expect(assigns(:post)).to eq(post)
      end

      it 'should update the post' do
        post.reload

        expect(post.title).to eq(data[:title])
        expect(post.content).to eq(data[:content])
      end

      it 'should redirect to the post' do
        expect(response)
          .to redirect_to(subcreddit_post_path(assigns(:post).subcreddit,
                                               assigns(:post)))
      end

      it 'should display a notice flash message' do
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid data' do
      before(:each) { data[:title] = '' }

      it 'should render :edit' do
        put :update, id: post, subcreddit_id: post.subcreddit, post: data

        expect(response).to render_template(:edit)
      end
    end
  end

  context '#destroy' do
    let!(:post) { create(:post, subcreddit: subcreddit) }

    it 'should delete the post' do
      expect { delete :destroy, subcreddit_id: subcreddit, id: post }
        .to change(Post, :count).by(-1)
    end

    it 'should redirect to the subcreddit index' do
      expect(delete :destroy, subcreddit_id: subcreddit, id: post)
        .to redirect_to(subcreddits_path(subcreddit))
    end

    it 'should flash notify that the post was deleted' do
      delete :destroy, subcreddit_id: subcreddit, id: post

      expect(flash[:notice]).to be_present
    end
  end
end
