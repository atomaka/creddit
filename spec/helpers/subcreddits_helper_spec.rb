require 'rails_helper'

describe SubcredditsHelper do
  describe '#subcreddit_name' do
    context 'when valid subcreddit provided' do
      let(:subcreddit) { create(:subcreddit) }

      it 'should set the title to a link to the subcreddit'
    end

    context 'when an invalid subcreddit is provided' do
      it 'should set the title to a link to the frontpage'
    end
  end
end
