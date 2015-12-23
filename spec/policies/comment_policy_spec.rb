require 'rails_helper'

describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }

  context 'when user is a guest' do
    let(:comment) { create(:comment) }
    let(:user) { GuestUser.new }

    it { should grant(:index) }
    it { should grant(:show) }

    it { should_not grant(:new) }
    it { should_not grant(:create) }
    it { should_not grant(:edit) }
    it { should_not grant(:update) }
    it { should_not grant(:destroy) }
  end

  context 'when user is registered' do
    let(:user) { create(:user) }

    context 'when not owner' do
      let(:comment) { create(:comment) }

      it { should grant(:index) }
      it { should grant(:show) }
      it { should grant(:new) }
      it { should grant(:create) }

      it { should_not grant(:edit) }
      it { should_not grant(:update) }
      it { should_not grant(:destroy) }
    end

    context 'when owner' do
      let(:comment) { create(:comment, user: user) }

      it { should grant(:index) }
      it { should grant(:show) }
      it { should grant(:new) }
      it { should grant(:create) }
      it { should grant(:edit) }
      it { should grant(:update) }
      it { should grant(:destroy) }
    end
  end
end
