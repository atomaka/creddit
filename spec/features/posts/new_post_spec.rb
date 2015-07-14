require 'rails_helper'

describe 'New Post', type: :feature do
  context 'when signed in' do
    let!(:user) { create(:user) }
    let!(:subcreddit) { create(:subcreddit) }
    let!(:post) { build(:post, subcreddit: subcreddit) }

    before(:each) { signin(user: user) }

    context 'with valid data' do
      before(:each) do
        visit new_subcreddit_post_path(subcreddit)

        fill_in :post_title, with: post.title
        fill_in :post_link, with: post.link
        fill_in :post_content, with: post.content

        click_button 'Create Post'
      end

      it 'should notify that a new post was created' do
        expect(page).to have_content('created')
      end

      it 'should display the new post' do
        expect(page).to have_content(post.title)
      end
    end

    context 'with invalid data' do
      before(:each) do
        visit new_subcreddit_post_path(subcreddit)

        post.title = ''

        fill_in :post_title, with: post.title
        fill_in :post_link, with: post.link
        fill_in :post_content, with: post.content

        click_button 'Create Post'
      end

      it 'should display errors' do
        expect(page).to have_content("can't be blank")
      end
    end
  end
end
