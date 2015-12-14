require 'rails_helper'

describe 'Edit Comment', type: :feature do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }

  context 'when signed in' do
    let!(:comment) { create(:comment, post: post, user: user) }

    before(:each) { signin(user: user) }

    context 'when owner' do
      let(:content) { 'Some different data' }

      context 'with valid data' do
        before(:each) do
          visit edit_subcreddit_post_comment_path(post.subcreddit,
                                                  post,
                                                  comment)

          fill_in :comment_content, with: content

          click_button 'Update Comment'
        end

        it 'should notify that the comment was edited' do
          expect(page).to have_content('updated')
        end

        it 'should update the comment' do
          expect(page).to have_content(content)
        end
      end
    end

    context 'when not owner' do
      let!(:comment) { create(:comment, post: post) }

      it 'should not allow editing of comment' do
        visit edit_subcreddit_post_comment_path(post.subcreddit, post, comment)

        expect(page).to have_content('not authorized')
      end
    end
  end

  context 'when not signed in' do
    let!(:comment) { create(:comment, post: post) }

    it 'should not allow editing of comment' do
      visit edit_subcreddit_post_comment_path(post.subcreddit, post, comment)

      expect(page).to have_content('not authorized')
    end
  end
end
