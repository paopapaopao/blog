# frozen_string_literal: true

RSpec.shared_examples 'all attributes are valid' do
  it do
    expect(subject).to be_valid
    expect(subject.errors).not_to be_present
    expect(subject.errors.to_hash.keys).to eq []
    expect(subject.errors.to_hash.values).to eq []
  end
end
