require 'rails_helper'

describe 'Signup', type: :feature do
  before(:each) { signout }

  context 'when not signed in' do
    let(:user) { build_stubbed(:user) }

    it 'should display the create account link' do
      visit root_path

      expect(page).to have_link('Create Account')
    end

    context 'with valid details' do
      it 'should create a new user' do
        visit signup_path

        fill_in :user_username, with: user.username
        fill_in :user_password, with: user.password
        fill_in :user_email, with: user.email

        click_button 'Create User'

        expect(page).to have_content('created')
      end
    end

    context 'with invalid details' do
      it 'should return to the form and display errors' do
        visit signup_path

        fill_in :user_username, with: ''
        fill_in :user_password, with: user.password
        fill_in :user_email, with: user.email

        click_button 'Create User'

        expect(page).to have_content("can't be blank")
      end
    end
  end

  context 'when signed in' do
    let(:user) { create(:user) }

    before(:each) { signin(user: user) }

    it 'should not display the create account link' do
      visit root_path

      expect(page).to_not have_link('Create Account')
    end
  end
end
