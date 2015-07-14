require 'rails_helper'

describe 'New Subcreddit', type: :feature do
  before(:each) { signout }

  context 'when not signed in' do
    it 'should not be able to create a new subcreddit'
  end

  context 'when signed in' do
    let(:user) { create(:user) }
    let(:subcreddit) { build_stubbed(:subcreddit) }
    before(:each) { signin(user: user) }

    context 'with valid data' do
      before(:each) do
        visit new_subcreddit_path

        fill_in :subcreddit_name, with: subcreddit.name

        click_button 'Create Subcreddit'
      end

      it 'should notify that a new subcreddit was created' do
        expect(page).to have_content('created')
      end

      it 'should forward you to the new subcreddit' do
        expect(page).to have_content(subcreddit.name)
      end
    end

    context 'with invalid data' do
      before(:each) do
        subcreddit.name = ''

        visit new_subcreddit_path
        fill_in :subcreddit_name, with: subcreddit.name
        click_button 'Create Subcreddit'
      end

      it 'should display errors' do
        expect(page).to have_content("can't be blank")
      end
    end
  end
end
