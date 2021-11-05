require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { build :article }

  context 'When the name attribute is invalid' do
    it do
      subject.name = nil
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :name
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.name = ''
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :name
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.name = ' '
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :name
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.name = (create :article).name
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :name
      expect(subject.errors.to_hash.values[0]).to include "has already been taken"
    end
  end

  context 'When the body attribute is invalid' do
    it do
      subject.body = nil
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :body
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.body = ''
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :body
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.body = ' '
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :body
      expect(subject.errors.to_hash.values[0]).to include "can't be blank"

      subject.body = 'a' * 4
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :body
      expect(subject.errors.to_hash.values[0]).to include "is too short (minimum is 5 characters)"
    end
  end

  context 'When all the attributes are valid' do
    it_behaves_like 'all attributes are valid'
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
