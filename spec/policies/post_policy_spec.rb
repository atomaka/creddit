require 'rails_helper'

describe PostPolicy do
  subject { PostPolicy.new(user, post) }

  context 'when user is a guest' do
    let(:post) { create(:post) }
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
      let(:post) { create(:post) }

      it { should grant(:index) }
      it { should grant(:show) }
      it { should grant(:new) }
      it { should grant(:create) }

      it { should_not grant(:edit) }
      it { should_not grant(:update) }
      it { should_not grant(:destroy) }
    end

    context 'when owner' do
      let(:post) { create(:post, user: user) }

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
