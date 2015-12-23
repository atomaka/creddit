require 'rails_helper'

describe 'New Post', type: :feature do
  let!(:subcreddit) { create(:subcreddit) }

  context 'when signed in' do
    let!(:user) { create(:user) }
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

  context 'when not signed in' do
    let!(:user) { GuestUser.new }
    let!(:post) { create(:post, subcreddit: subcreddit) }

    it 'should notify user they cannot create' do
      visit new_subcreddit_post_path(subcreddit)

      expect(page).to have_content 'not authorized'
    end
  end
end
