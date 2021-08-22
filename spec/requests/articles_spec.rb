require 'rails_helper'

RSpec.describe "Articles", type: :request do
  subject { create :article }

  let :invalid_attributes do
    {
      name: nil,
      body: nil
    }
  end
  let :valid_attributes do
    {
      name: FFaker::Movie.title,
      body: FFaker::Lorem.paragraph
    }
  end

  before :each do
    @user = create :user
    sign_in @user
  end

  describe "GET /index" do
    it do
      get articles_path
      expect(response).to be_successful
      expect(response).to have_http_status :ok
      expect(response).to render_template :index
    end
  end

  describe "GET /show" do
    context 'When non-existent' do
      it do
        expect { get article_path(0) }.to raise_exception ActiveRecord::RecordNotFound
      end
    end

    context 'When existent' do
      it do
        get article_path(subject)
        expect(response).to be_successful
        expect(response).to have_http_status :ok
        expect(response).to render_template :show
      end
    end
  end

  describe "GET /new" do
    it do
      get new_article_path
      expect(response).to be_successful
      expect(response).to have_http_status :ok
      expect(response).to render_template :new
    end
  end

  describe "GET /edit" do
    context 'When non-existent' do
      it do
        expect { get edit_article_path(0) }.to raise_exception ActiveRecord::RecordNotFound
      end
    end

    context 'When existent' do
      it do
        get edit_article_path(subject)
        expect(response).to be_successful
        expect(response).to have_http_status :ok
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST /create' do
    context 'With invalid arguments' do
      it do
        post articles_path, params: { article: invalid_attributes }
        expect(response).to_not be_successful
        expect(response).to have_http_status :unprocessable_entity
        expect { response }.to change(Article, :count).by 0
        expect(response).to render_template :new
      end
    end

    context 'With valid arguments' do
      it do
        attributes = valid_attributes
        post articles_path, params: { article: attributes }
        # ? expected to be truthy, got false
        # expect(response).to be_successful
        expect(response).to have_http_status :found
        expect(Article.last.name).to eq attributes[:name]
        expect(Article.last.body).to eq attributes[:body]
        expect(Article.last.user_id).to eq @user.id
        # ? expected `Article.count` to have changed by 1, but was changed by 0
        # expect { response }.to change(Article, :count).by 1
        expect(response).to redirect_to article_path(Article.last)
      end

      it do
        expect do
          post articles_path, params: { article: valid_attributes }
        end.to change(Article, :count).by 1
      end
    end
  end

  describe 'PATCH /update' do
    context 'With invalid arguments' do
      it do
        patch article_path(subject), params: { article: invalid_attributes }
        expect(response).to_not be_successful
        expect(response).to have_http_status :unprocessable_entity
        expect(response).to render_template :edit
      end
    end

    context 'With valid arguments' do
      it do
        attributes = valid_attributes
        patch article_path(subject), params: { article: attributes }
        subject.reload
        # ? expected to be truthy, got false
        # expect(response).to be_successful
        expect(response).to have_http_status :found
        expect(subject.name).to eq attributes[:name]
        expect(subject.body).to eq attributes[:body]
        # ? expected: n got: n + 1
        # expect(subject.user_id).to eq @user.id
        expect(response).to redirect_to article_path(subject)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'When non-existent' do
      it do
        expect { delete article_path(0) }.to raise_exception ActiveRecord::RecordNotFound
      end
    end

    context 'When existent' do
      it do
        delete article_path(subject)
        # ? expected to be truthy, got false
        # expect(response).to be_successful
        expect(response).to have_http_status :found
        expect { Article.find(subject.id) }.to raise_exception ActiveRecord::RecordNotFound
        # ? expected `Article.count` to have changed by -1, but was changed by 0
        # expect { response }.to change(Article, :count).by -1
        expect(response).to redirect_to articles_path
      end

      # it do
      #   expect { delete article_path(subject) }.to change(Article, :count).by -1
      # end
    end
  end
end
