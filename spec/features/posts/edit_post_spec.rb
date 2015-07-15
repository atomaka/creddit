require 'rails_helper'

describe 'Edit Post', type: :feature do
  context 'when signed in' do
    let!(:user) { create(:user) }
    let!(:subcreddit) { create(:subcreddit) }
    let!(:post) { create(:post, subcreddit: subcreddit, user: user) }
    let(:new_post) { build_stubbed(:post) }

    before(:each) { signin(user: user) }

    context 'with valid data' do
      before(:each) do
        visit edit_subcreddit_post_path(subcreddit, post)

        fill_in :post_title, with: new_post.title
        fill_in :post_link, with: new_post.link
        fill_in :post_content, with: new_post.content

        click_button 'Update Post'
      end

      it 'should notify that the post was edited' do
        expect(page).to have_content('updated')
      end

      it 'should show the post' do
        expect(page).to have_content(new_post.title)
      end
    end
  end
end
