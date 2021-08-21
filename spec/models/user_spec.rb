require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  context 'When email is invalid' do
    it do
      subject.email = nil
      expect(subject).to_not be_valid

      subject.email = ''
      expect(subject).to_not be_valid

      subject.email = ' '
      expect(subject).to_not be_valid

      subject.email = (create :user).email
      expect(subject).to_not be_valid
    end
  end

  context 'When password is invalid' do
    it do
      subject.password = nil
      expect(subject).to_not be_valid

      subject.password = ''
      expect(subject).to_not be_valid

      subject.password = ' '
      expect(subject).to_not be_valid

      subject.password = 'a' * 5
      expect(subject).to_not be_valid

      subject.password = 'a' * 129
      expect(subject).to_not be_valid
    end
  end

  context 'When all attributes are valid' do
    it { expect(subject).to be_valid }
  end

  context 'Association with Articles' do
    it { expect(described_class.reflect_on_association(:articles).macro).to eq :has_many }
  end
end
