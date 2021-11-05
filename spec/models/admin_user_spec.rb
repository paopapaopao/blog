require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  subject { build :admin_user }

  context 'When the email attribute is invalid' do
    it_behaves_like 'an attribute is invalid', :email, "can't be blank"  do
      before { subject.email = nil }
    end

    it_behaves_like 'an attribute is invalid', :email, "can't be blank" do
      before { subject.email = '' }
    end

    it_behaves_like 'an attribute is invalid', :email, "can't be blank" do
      before { subject.email = ' ' }
    end

    it_behaves_like 'an attribute is invalid', :email, 'is invalid' do
      before { subject.email = 'a' }
    end

    it_behaves_like 'an attribute is invalid', :email, 'has already been taken' do
      before { subject.email = (create :admin_user).email }
    end
  end

  context 'When the password attribute is invalid' do
    it_behaves_like 'an attribute is invalid', :password, "can't be blank" do
      before { subject.password = nil }
    end

    it_behaves_like 'an attribute is invalid', :password, "can't be blank" do
      before { subject.password = '' }
    end

    it_behaves_like 'an attribute is invalid', :password, "can't be blank" do
      before { subject.password = ' ' }
    end

    it_behaves_like 'an attribute is invalid', :password, "is too short (minimum is #{AdminUser.password_length.min} characters)" do
      before { subject.password = 'a' * 5 }
    end

    it_behaves_like 'an attribute is invalid', :password, "is too long (maximum is #{AdminUser.password_length.max} characters)" do
      before { subject.password = 'a' * 129 }
    end
  end

  context 'When all the attributes are valid' do
    it_behaves_like 'all attributes are valid'
  end
end
