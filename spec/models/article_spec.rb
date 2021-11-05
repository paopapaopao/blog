require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { build :article }

  context 'When the name attribute is invalid' do
    it_behaves_like 'an attribute is invalid', :name, "can't be blank"  do
      before { subject.name = nil }
    end

    it_behaves_like 'an attribute is invalid', :name, "can't be blank" do
      before { subject.name = '' }
    end

    it_behaves_like 'an attribute is invalid', :name, "can't be blank" do
      before { subject.name = ' ' }
    end

    it_behaves_like 'an attribute is invalid', :name, 'has already been taken' do
      before { subject.name = (create :article).name }
    end
  end

  context 'When the body attribute is invalid' do
    it_behaves_like 'an attribute is invalid', :body, "can't be blank"  do
      before { subject.body = nil }
    end

    it_behaves_like 'an attribute is invalid', :body, "can't be blank" do
      before { subject.body = '' }
    end

    it_behaves_like 'an attribute is invalid', :body, "can't be blank" do
      before { subject.body = ' ' }
    end

    it_behaves_like 'an attribute is invalid', :body, "is too short (minimum is 5 characters)" do
      before { subject.body = 'a' * 4 }
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
