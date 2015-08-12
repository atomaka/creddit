require 'rails_helper'

describe 'Profile', type: :feature do
  let!(:user) { create(:user) }

  it 'should display a user profile' do
    visit user_path(user)

    expect(page).to have_content(user.username)
  end

  context 'when the user has commented' do
    let!(:comments) { 5.times.collect { create(:comment, user: user) } }

    it 'should display user comments' do
      visit user_path(user)

      comments.each do |comment|
        expect(page).to have_content(comment.content)
      end
    end
  end
end
