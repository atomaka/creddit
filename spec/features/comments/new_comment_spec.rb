require 'rails_helper'

describe 'New Comment', type: :feature do
  let!(:post) { create(:post) }
  let(:comment) { build(:comment) }

  context 'when signed in' do
    let(:user) { create(:user) }

    before(:each) { signin(user: user) }

    context 'with valid data' do
      before(:each) do
        visit subcreddit_post_path(post.subcreddit, post)

        fill_in :comment_content, with: comment.content

        click_button 'Create Comment'
      end

      it 'should notify that a new content was created' do
        expect(page).to have_content('saved')
      end

      it 'should display the new comment' do
        expect(page).to have_content(comment.content)
      end

      context 'when nesting comment' do
        let!(:comment) { create(:comment, post: post) }

        it 'should display a nested comment' do
          visit subcreddit_post_comment_path(post.subcreddit, post, comment)

          fill_in :comment_content, with: comment.content
          click_button 'Create Comment'

          expect(page).to have_css('div.nested_comments')
        end
      end
    end

    context 'with invalid data' do
      before(:each) do
        visit subcreddit_post_path(post.subcreddit, post)

        fill_in :comment_content, with: ''

        click_button 'Create Comment'
      end

      it 'should display errors' do
        expect(page).to have_content('could not')
      end
    end
  end
end
