require 'rails_helper'

describe 'New Subcreddit', type: :feature do
  let!(:subcreddits) { 5.times.collect { create(:subcreddit) } }

  it 'should list all subcreddits' do
    visit subcreddits_path

    subcreddits.each do |subcreddit|
      expect(page).to have_link(subcreddit.name, subcreddit_path(subcreddit))
    end
  end
end
