require 'rails_helper'

describe Post, type: :model do
  let(:post) { build(:post) }

  it { should belong_to(:user) }
  it { should belong_to(:subcreddit) }

  context 'with valid data' do
    it 'should be valid' do
      expect(post).to be_valid
    end

    it 'should allow blank content' do
      post.content = ''

      expect(post).to be_valid
    end

    it 'should allow a blank link' do
      post.link = ''

      expect(post).to be_valid
    end
  end

  context 'with invalid data' do
    it 'should not allow a blank title' do
      post.title = ''

      expect(post).to be_invalid
    end

    it 'should not allow a long title' do
      post.title = 'a' * 301

      expect(post).to be_invalid
    end

    it 'should not allow long content' do
      post.content = 'a' * 15001

      expect(post).to be_invalid
    end
  end

  context '#to_param' do
    it 'generates the correct param' do
      post.save

      expect(post.to_param).to eq("#{post.id}-#{post.title.parameterize}")
    end
  end
end
