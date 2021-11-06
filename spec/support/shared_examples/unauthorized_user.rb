# frozen_string_literal: true

RSpec.shared_examples 'unauthorized user' do
  it do
    expect(response).not_to be_successful
    expect(response).to have_http_status :found
    expect(response).to redirect_to root_path
  end
end
