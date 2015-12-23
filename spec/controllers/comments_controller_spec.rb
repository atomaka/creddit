require 'rails_helper'

describe CommentsController, type: :controller do
  let!(:user) { build(:user) }
  let!(:subcreddit) { create(:subcreddit) }
  let!(:tpost) { create(:post, subcreddit: subcreddit) }
  let(:data) { { content: 'Here is some updated content for a comment' } }

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  describe '#show' do
    let!(:comment) { create(:comment) }
    before(:each) do
      get :show,
        subcreddit_id: comment.post.subcreddit,
        post_id: comment.post,
        id: comment
    end

    it 'should render :show' do
      expect(response).to render_template(:show)
    end

    it 'should assign correct Comment to @comment' do
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe '#new' do
    let(:comment) { build(:comment) }
    before(:each) do
      get :new,
        subcreddit_id: comment.post.subcreddit,
        post_id: comment.post
    end

    it 'should render :new' do
      expect(response).to render_template(:new)
    end

    it 'should assign new Comment to @comment' do
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe '#create' do
    context 'with valid data' do
      it 'should create a comment' do
        expect do
          post :create,
            subcreddit_id: subcreddit,
            post_id: tpost,
            comment: data
        end.to change(Comment, :count).by(1)
      end

      it 'should redirect to the parent post' do
        expect(post :create,
                subcreddit_id: subcreddit,
                post_id: tpost,
                comment: data
          ).to redirect_to(subcreddit_post_path(assigns(:post).subcreddit,
                                                assigns(:post)))
      end

      it 'should send a notice flash message' do
        expect(post :create,
                subcreddit_id: subcreddit,
                post_id: tpost,
                comment: data)

        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid data' do
      before(:each) { data['content'] = '' }

      it 'should not create a new comment' do
        expect do
          post :create,
            subcreddit_id: subcreddit,
            post_id: tpost,
            comment: data
        end.to change(Comment, :count).by(0)
      end

      it 'should render :new' do
        expect(post :create,
                subcreddit_id: subcreddit,
                post_id: tpost,
                comment: data
        ).to redirect_to(subcreddit_post_path(subcreddit, tpost))
      end
    end
  end

  describe '#edit' do
    context 'when owner' do
      let!(:comment) { create(:comment, user: user) }
      before(:each) do
        get :edit,
          id: comment,
          post_id: comment.post,
          subcreddit_id: comment.post.subcreddit
      end

      context 'with valid comment' do
        it 'should render :edit' do
          expect(response).to render_template(:edit)
        end

        it 'should assign correct Comment to @comment' do
          expect(assigns(:comment)).to eq(comment)
        end
      end
    end
  end

  context '#update' do
    let(:data) { { content: 'Some edited comment content goes here' } }

    context 'with valid data' do
      let!(:comment) { create(:comment, user: user) }

      context 'when owner' do
        before(:each) do
          put :update,
            id: comment,
            post_id: comment.post,
            subcreddit_id: comment.post.subcreddit,
            comment: data
        end

        it 'should assign correct Comment to @comment' do
          expect(assigns(:comment)).to eq(comment)
        end

        it 'should update the comment' do
          comment.reload

          expect(comment.content).to eq(data[:content])
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
        before(:each) { data[:content] = '' }

        it 'should render :edit' do
          put :update,
            id: comment,
            post_id: comment.post,
            subcreddit_id: comment.post.subcreddit,
            comment: data

          expect(response).to render_template(:edit)
        end
      end
    end
  end

  context '#destroy' do
    context 'when owner' do
      let!(:comment) { create(:comment, user: user) }

      it 'should delete the post' do
        delete :destroy,
          id: comment,
          post_id: comment.post,
          subcreddit_id: comment.post.subcreddit

        comment.reload
        expect(comment.destroyed?).to be(true)
      end

      it 'should redirect to the post' do
        delete :destroy,
          id: comment,
          post_id: comment.post,
          subcreddit_id: comment.post.subcreddit

        expect(response)
          .to redirect_to(subcreddit_post_path(assigns(:subcreddit),
                                               assigns(:post)))
      end

      it 'should send a notice flash message' do
        delete :destroy,
          id: comment,
          post_id: comment.post,
          subcreddit_id: comment.post.subcreddit
        expect(flash[:notice]).to be_present
      end
    end
  end
end
