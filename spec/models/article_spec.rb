require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { build :article }

  context 'When name is invalid' do
    it do
      subject.name = nil
      expect(subject).to_not be_valid

      subject.name = ''
      expect(subject).to_not be_valid

      subject.name = ' '
      expect(subject).to_not be_valid

      subject.name = (create :article).name
      expect(subject).to_not be_valid
    end
  end

  context 'When body is invalid' do
    it do
      subject.body = nil
      expect(subject).to_not be_valid

      subject.body = ''
      expect(subject).to_not be_valid

      subject.body = ' '
      expect(subject).to_not be_valid

      subject.body = 'a' * 4
      expect(subject).to_not be_valid
    end
  end

  context 'When all attributes are valid' do
    it { expect(subject).to be_valid }
  end

  context 'Association with User' do
    it { expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to }
  end

  context 'Association with Comments' do
    it { expect(described_class.reflect_on_association(:comments).macro).to eq :has_many }
  end

  context 'Association with Tags' do
    it { expect(described_class.reflect_on_association(:tags).macro).to eq :has_many }
  end
end
