require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build :tag }

  context 'When all attributes are valid' do
    it do
      expect(subject).to be_valid
      expect(subject.errors).to_not be_present
    end
  end

  context 'Association with Article' do
    it { expect(described_class.reflect_on_association(:article).macro).to eq :belongs_to }
  end
end
