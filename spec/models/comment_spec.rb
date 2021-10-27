require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build :comment }

  context 'When all the attributes are valid' do
    it do
      expect(subject).to be_valid
      expect(subject.errors).not_to be_present
      expect(subject.errors.to_hash.keys).to eq []
      expect(subject.errors.to_hash.values).to eq []
    end
  end

  context 'Association with User' do
    it { expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to }
  end

  context 'Association with Article' do
    it { expect(described_class.reflect_on_association(:article).macro).to eq :belongs_to }
  end
end
