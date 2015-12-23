require 'rails_helper'

describe 'Edit Subcreddit', type: :feature do
  before(:each) { signout }

  context 'when logged in' do
    let!(:user) { create(:user) }
    before(:each) { signin(user: user) }

    context 'when user is owner' do
      let!(:subcreddit) { create(:subcreddit, owner: user) }

      context 'when board is open' do
        before(:each) do
          visit subcreddits_path
          click_link 'Edit'
          check :subcreddit_closed
          click_button 'Update Subcreddit'
        end

        it 'should be notified the subcreddit was updated' do
          expect(page).to have_content('updated')
        end

        it 'should close the board when closed is checked' do
          expect(page).to have_content('closed')
        end
      end

      context 'when board is closed' do
        let!(:subcreddit) do
          create(:subcreddit, owner: user, closed_at: Time.now)
        end

        before(:each) do
          visit subcreddits_path
          click_link 'Edit'
          uncheck :subcreddit_closed
          click_button 'Update Subcreddit'
        end

        it 'should open the board when closed is checked' do
          expect(page).to_not have_content('closed')
        end
      end
    end

    context 'when not owner' do
      let!(:subcreddit) { create(:subcreddit) }

      it 'should not allow editing of subcreddit' do
        visit subcreddits_path
        click_link 'Edit'

        expect(page).to have_content('not authorized')
      end
    end
  end

  context 'when not logged in' do

  end
end
