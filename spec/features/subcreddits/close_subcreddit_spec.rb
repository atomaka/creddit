require 'rails_helper'

describe 'Edit Subcreddit', type: :feature do
  before(:each) { signout }

  context 'when logged in' do
    context 'when board is open' do
      let!(:subcreddit) { create(:subcreddit) }
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
      let!(:subcreddit) { create(:subcreddit, closed_at: Time.now) }
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
end
