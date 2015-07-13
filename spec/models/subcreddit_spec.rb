require 'rails_helper'

describe Subcreddit, type: :model do
  let(:subcreddit) { build(:subcreddit) }

  it { should belong_to(:owner).class_name('User') }

  context 'with valid data' do
    it 'should be valid' do
      expect(subcreddit).to be_valid
    end

    it 'should allow spaces in the name' do
      subcreddit.name = 'Testing Spaces'
      expect(subcreddit).to be_valid
    end

    it 'should sluggify the name' do
      subcreddit.name = 'Testing Spaces 1'
      subcreddit.save
      expect(subcreddit.slug).to eq('testing_spaces_1')
    end

    it 'should set closed_at if closed is true and closed_at is nil' do
      Timecop.freeze do
        subcreddit.closed = '1'
        subcreddit.save
        expect(subcreddit.closed_at).to eq(Time.now)
      end
    end

    it 'should not change closed_at if closed and closed_at is not nil' do
      subcreddit.closed_at = Time.now - 3.days

      Timecop.freeze do
        subcreddit.closed = '1'
        subcreddit.save
        expect(subcreddit.closed_at).to_not eq(Time.now)
      end
    end

    it 'should clear closed_at if closed is "0"' do
      subcreddit.closed_at = Time.now

      subcreddit.closed = '0'
      subcreddit.save
      expect(subcreddit.closed_at).to eq(nil)
    end
  end

  context 'with invalid data' do
    it 'should not allow a blank name' do
      subcreddit.name = ''

      expect(subcreddit).to be_invalid
    end

    it 'should not allow short names' do
      subcreddit.name = 'a' * 2

      expect(subcreddit).to be_invalid
    end

    it 'should not allow long names' do
      subcreddit.name = 'a' * 22

      expect(subcreddit).to be_invalid
    end

    it 'should only allow acceptable characters in the name' do
      subcreddit.name = 'Testing!'

      expect(subcreddit).to be_invalid
    end

    it 'should not be allowed to end with a space' do
      subcreddit.name = 'Testing '

      expect(subcreddit).to be_invalid
    end

    it 'should not be allowed to begin with a space' do
      subcreddit.name = ' Testing'

      expect(subcreddit).to be_invalid
    end

    it 'should not allow duplicate names' do
      original = create(:subcreddit)
      duplicate = build(:subcreddit, name: original.name)

      expect(duplicate).to be_invalid
    end

    it 'should not allow duplicate names (case insensitive)' do
      original = create(:subcreddit)
      duplicate = build(:subcreddit, name: original.name.upcase)

      expect(duplicate).to be_invalid
    end

    it 'should not use a reserved keyword' do
      subcreddit.name = 'New'

      expect(subcreddit).to be_invalid
    end
  end

  context '#closed?' do
    let(:subcreddit) { build(:subcreddit) }

    context 'when a subcreddit is closed' do
      before(:each) { subcreddit.closed_at = Time.now }

      it 'should return true' do
        expect(subcreddit.closed?).to be(true)
      end
    end

    context 'when a subcreddit is open' do
      it 'should return false' do
        expect(subcreddit.closed?).to be(false)
      end
    end
  end
end
