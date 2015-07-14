require 'rails_helper'

describe 'Sign In', type: :feature do
  before(:each) { signout }

  context 'when not signed in' do
    let(:user) { create(:user) }

    it 'should display the sign in link' do
      visit root_path

      expect(page).to have_link('Sign In')
    end

    context 'with valid details' do
      it 'should sign in successfully' do
        signin(user: user)

        expect(page).to have_content('signed in')
      end
    end

    context 'with invalid details' do
      it 'should return to the form and display errors' do
        signin(username: user.username, password: 'garbage')

        expect(page).to have_content('incorrect')
      end
    end
  end

  context 'when signed in' do
    let(:user) { create(:user) }

    before(:each) { signin(user: user) }

    it 'should not display the sign in link' do
      visit root_path

      expect(page).to_not have_link('Sign In')
    end
  end
end
