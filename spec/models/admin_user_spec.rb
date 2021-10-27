require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  subject { build :admin_user }

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
      expect(subject.errors.to_hash.values[0]).to include "is invalid"

      subject.email = (create :admin_user).email
      expect(subject).not_to be_valid
      expect(subject.errors).to be_present
      expect(subject.errors.to_hash.keys).to include :email
      expect(subject.errors.to_hash.values[0]).to include "has already been taken"
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
    it do
      expect(subject).to be_valid
      expect(subject.errors).not_to be_present
      expect(subject.errors.to_hash.keys).to eq []
      expect(subject.errors.to_hash.values).to eq []
    end
  end
end
