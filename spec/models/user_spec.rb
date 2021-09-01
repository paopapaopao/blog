require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  context 'When email is invalid' do
    it do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:email)

      subject.email = ''
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:email)

      subject.email = ' '
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:email)

      subject.email = (create :user).email
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:email)
    end
  end

  context 'When password is invalid' do
    it do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:password)

      subject.password = ''
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:password)

      subject.password = ' '
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:password)

      subject.password = 'a' * 5
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:password)

      subject.password = 'a' * 129
      expect(subject).to_not be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include(:password)
    end
  end

  context 'When all attributes are valid' do
    it do
      expect(subject).to be_valid
      expect(subject.errors).to_not be_present
      expect(subject.errors.to_hash.keys).to_not include(:email)
      expect(subject.errors.to_hash.keys).to_not include(:password)
    end
  end

  context 'Association with Articles' do
    it { expect(described_class.reflect_on_association(:articles).macro).to eq :has_many }
  end
end
