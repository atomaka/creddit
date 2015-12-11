require 'rails_helper'

describe Comment, type: :model do
  let(:comment) { build(:comment) }

  it { should belong_to(:user) }
  it { should belong_to(:post).counter_cache(true) }

  it { should delegate_method(:username).to(:user).with_prefix }
  it { should delegate_method(:subcreddit).to(:post).with_prefix }

  context 'with valid data' do
    it 'should be valid' do
      expect(comment).to be_valid
    end
  end

  context 'with invalid data' do
    it 'should not be valid with blank content' do
      comment.content = ''

      expect(comment).to be_invalid
    end
  end

  context 'when comment is deleted' do
    before(:each) { comment.deleted_at = Time.now }

    context '#destroyed?' do
      it 'should respond with true' do
        expect(comment.destroyed?).to be(true)
      end
    end

    context '#content' do
      it 'should return [deleted]' do
        expect(comment.content).to eq('[deleted]')
      end
    end
  end

  context 'when comment is not deleted' do
    context '#destroyed?' do
      it 'should respond with false' do
        expect(comment.destroyed?).to be(false)
      end
    end

    context '#content' do
      it 'should return comment content' do
        expect(comment.content).to eq(comment.content)
      end
    end
  end

  context '#destroy' do
    it 'should set the deleted_at time appropriately' do
      Timecop.freeze do
        comment.destroy
        expect(comment.deleted_at).to eq(Time.now)
      end
    end
  end
end
