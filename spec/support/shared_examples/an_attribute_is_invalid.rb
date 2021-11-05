# frozen_string_literal: true

RSpec.shared_examples 'an attribute is invalid' do |key, value|
  it do
    expect(subject).not_to be_valid
    expect(subject.errors).to be_present
    expect(subject.errors.to_hash.keys).to include key
    expect(subject.errors.to_hash.values[0]).to include value
  end
end
