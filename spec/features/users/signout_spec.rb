require 'rails_helper'

describe 'Sign Out', type: :feature do
  before(:each) { signout }

  context 'when not signed in' do
    it 'should not display the sign out link' do
      visit root_path

      expect(page).to_not have_link('Sign Out')
    end
  end

  context 'when signed in' do
    let(:user) { create(:user) }

    before(:each) { signin(user: user) }

    it 'should display the sign out link' do
      visit root_path

      expect(page).to have_link('Sign Out')
    end

    it 'should sign a user out' do
      visit root_path
      click_link('Sign Out')

      expect(page).to have_content('signed out')
    end
  end
end
