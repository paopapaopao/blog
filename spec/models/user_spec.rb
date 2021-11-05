require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  context 'When the email attribute is invalid' do
    it do
      subject.email = nil
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :email
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.email = ''
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :email
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.email = ' '
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :email
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.email = 'a'
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :email
      expect(subject.errors.to_hash.values[0]).to include 'is invalid'

      subject.email = (create :user).email
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :email
      expect(subject.errors.to_hash.values[0]).to include 'has already been taken'
    end
  end

  context 'When the password attribute is invalid' do
    it do
      subject.password = nil
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :password
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.password = ''
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :password
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.password = ' '
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :password
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.password = 'a' * 5
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :password
      expect(subject.errors.to_hash.values[0]).to include "is too short (minimum is #{User.password_length.min} characters)"

      subject.password = 'a' * 129
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :password
      expect(subject.errors.to_hash.values[0]).to include "is too long (maximum is #{User.password_length.max} characters)"
    end
  end

  context 'When all the attributes are valid' do
    it_behaves_like 'all attributes are valid'
  end

  context 'Association with Articles' do
    it { expect(described_class.reflect_on_association(:articles).macro).to eq :has_many }
  end
end
