require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build :comment }

  context 'When all attributes are valid' do
    it { expect(subject).to be_valid }
  end

  context 'Association with Article' do
    it { expect(described_class.reflect_on_association(:article).macro).to eq :belongs_to }
  end
end
