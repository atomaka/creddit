require 'rails_helper'

describe 'List Posts', type: :feature do
  let!(:subcreddit) { create(:subcreddit) }
  let!(:posts) { 10.times.collect { create(:post, subcreddit: subcreddit) } }

  it 'should list all posts for a subcreddit' do
    visit subcreddit_path(subcreddit)

    posts.each do |post|
      expect(page)
        .to have_link(post.title, subcreddit_post_path(post, post.subcreddit))
    end
  end
end
