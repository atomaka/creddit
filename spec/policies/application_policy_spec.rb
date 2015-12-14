require 'rails_helper'

describe ApplicationPolicy do
  subject { ApplicationPolicy.new(user, object) }
  let(:user) { create(:user) }
  let(:object) { double('Object') }

  it { should_not grant(:index) }
  it { should_not grant(:show) }
  it { should_not grant(:new) }
  it { should_not grant(:create) }
  it { should_not grant(:edit) }
  it { should_not grant(:update) }
  it { should_not grant(:destroy) }
end
