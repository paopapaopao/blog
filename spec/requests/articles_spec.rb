require 'rails_helper'

RSpec.describe "Articles", type: :request do
  # subject { create :article }

  before :each do
    @signed_in_user = create :user
    @signed_out_user = create :user
    @signed_in_user_article = FactoryBot.create(:article, user_id: @signed_in_user.id)
    @signed_out_user_article = FactoryBot.create(:article, user_id: @signed_out_user.id)
  end

  let :invalid_attributes do
    {
      name: nil,
      body: nil,
      user_id: nil
    }
  end
  let! :valid_attributes do
    {
      name: FFaker::Movie.title,
      body: FFaker::Lorem.paragraph,
      user_id: @signed_in_user.id
    }
  end
  let! :new_valid_attributes do
    {
      name: FFaker::Movie.title,
      body: FFaker::Lorem.paragraph
    }
  end

  describe "GET /index" do
    context 'When the user is not signed in' do
      it do
        get articles_path
        expect(response).to_not be_successful
        expect(response).to have_http_status :found
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'When the user is signed in' do
      it do
        sign_in @signed_in_user
        get articles_path
        expect(response).to be_successful
        expect(response).to have_http_status :ok
        expect(response).to render_template :index
      end
    end
  end

  describe "GET /show" do
    context 'When the user is not signed in' do
      context 'When the article does not exist' do
        it do
          expect { get article_path(0) }.to_not raise_error
          get article_path(0)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists but does not belong to the user' do
        it do
          get article_path(@signed_out_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists and belongs to the user' do
        it do
          get article_path(@signed_in_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    context 'When the user is signed in' do
      before(:each) { sign_in @signed_in_user }

      context 'When the article does not exist' do
        it do
          expect { get article_path(0) }.to raise_exception ActiveRecord::RecordNotFound
          get article_path(0)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          # ? why redirect to the sign in page?
          # expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists but does not belong to the user' do
        it do
          get article_path(@signed_out_user_article)
          expect(response).to be_successful
          expect(response).to have_http_status :ok
          expect(response).to render_template :show
        end
      end

      context 'When the article exists and belongs to the user' do
        it do
          get article_path(@signed_in_user_article)
          expect(response).to be_successful
          expect(response).to have_http_status :ok
          expect(response).to render_template :show
        end
      end
    end
  end

  describe "GET /new" do
    context 'When the user is not signed in' do
      it do
        get new_article_path
        expect(response).to_not be_successful
        expect(response).to have_http_status :found
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'When the user is signed in' do
      it do
        sign_in @signed_in_user
        get new_article_path
        expect(response).to be_successful
        expect(response).to have_http_status :ok
        expect(response).to render_template :new
      end
    end
  end

  describe "GET /edit" do
    context 'When the user is not signed in' do
      context 'When the article does not exist' do
        it do
          expect { get edit_article_path(0) }.to_not raise_error
          get edit_article_path(0)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists but does not belong to the user' do
        it do
          get edit_article_path(@signed_out_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists and belongs to the user' do
        it do
          get edit_article_path(@signed_in_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    context 'When the user is signed in' do
      before(:each) { sign_in @signed_in_user }

      context 'When the article does not exist' do
        it do
          expect { get edit_article_path(0) }.to raise_exception ActiveRecord::RecordNotFound
          get edit_article_path(0)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          # ? why redirect to the sign in page?
          # expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists but does not belong to the user' do
        it do
          get edit_article_path(@signed_out_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect(response).to redirect_to root_path
        end
      end

      context 'When the article exists and belongs to the user' do
        it do
          get edit_article_path(@signed_in_user_article)
          expect(response).to be_successful
          expect(response).to have_http_status :ok
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'POST /create' do
    context 'When the user is not signed in' do
      context 'With invalid arguments' do
        it do
          post articles_path, params: { article: invalid_attributes }
          expect(Article.last.name).to_not eq invalid_attributes[:name]
          expect(Article.last.body).to_not eq invalid_attributes[:body]
          expect(Article.last.user_id).to_not eq @signed_in_user.id
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect { response }.to change(Article, :count).by 0
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'With valid arguments' do
        it do
          post articles_path, params: { article: valid_attributes }
          expect(Article.last.name).to_not eq valid_attributes[:name]
          expect(Article.last.body).to_not eq valid_attributes[:body]
          expect(Article.last.user_id).to_not eq @signed_in_user.id
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect { response }.to change(Article, :count).by 0
          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    context 'When the user is signed in' do
      before(:each) { sign_in @signed_in_user }

      context 'With invalid arguments' do
        it do
          post articles_path, params: { article: invalid_attributes }
          expect(Article.last.name).to_not eq invalid_attributes[:name]
          expect(Article.last.body).to_not eq invalid_attributes[:body]
          expect(Article.last.user_id).to_not eq @signed_in_user.id
          expect(response).to_not be_successful
          expect(response).to have_http_status :unprocessable_entity
          expect { response }.to change(Article, :count).by 0
          expect(response).to render_template :new
        end
      end

      context 'With valid arguments' do
        it do
          post articles_path, params: { article: valid_attributes }
          expect(Article.last.name).to eq valid_attributes[:name]
          expect(Article.last.body).to eq valid_attributes[:body]
          expect(Article.last.user_id).to eq @signed_in_user.id
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          # ? expected `Article.count` to have changed by 1, but was changed by 0
          # expect { response }.to change(Article, :count).by 1
          expect(response).to redirect_to article_path(Article.last)
        end

        it do
          expect { post articles_path, params: { article: valid_attributes } }.to change(Article, :count).by 1
        end
      end
    end
  end

  describe 'PATCH /update' do
    context 'When the user is not signed in' do
      context 'When the article does not exist' do
        context 'With invalid arguments' do
          it do
            patch article_path(0), params: { article: invalid_attributes }
            expect(@signed_out_user_article.name).to_not eq invalid_attributes[:name]
            expect(@signed_out_user_article.body).to_not eq invalid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to new_user_session_path
          end
        end

        context 'With valid arguments' do
          it do
            patch article_path(0), params: { article: valid_attributes }
            expect(@signed_out_user_article.name).to_not eq valid_attributes[:name]
            expect(@signed_out_user_article.body).to_not eq valid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to new_user_session_path
          end
        end
      end

      context 'When the article exists but does not belong to the user' do
        context 'With invalid arguments' do
          it do
            patch article_path(@signed_out_user_article), params: { article: invalid_attributes }
            @signed_out_user_article.reload
            expect(@signed_out_user_article.name).to_not eq invalid_attributes[:name]
            expect(@signed_out_user_article.body).to_not eq invalid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to new_user_session_path
          end
        end

        context 'With valid arguments' do
          it do
            patch article_path(@signed_out_user_article), params: { article: valid_attributes }
            @signed_out_user_article.reload
            expect(@signed_out_user_article.name).to_not eq valid_attributes[:name]
            expect(@signed_out_user_article.body).to_not eq valid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to new_user_session_path
          end
        end
      end

      context 'When the article exists and belongs to the user' do
        context 'With invalid arguments' do
          it do
            patch article_path(@signed_in_user_article), params: { article: invalid_attributes }
            @signed_in_user_article.reload
            expect(@signed_in_user_article.name).to_not eq invalid_attributes[:name]
            expect(@signed_in_user_article.body).to_not eq invalid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to new_user_session_path
          end
        end

        context 'With valid arguments' do
          it do
            patch article_path(@signed_in_user_article), params: { article: valid_attributes }
            @signed_in_user_article.reload
            expect(@signed_in_user_article.name).to_not eq valid_attributes[:name]
            expect(@signed_in_user_article.body).to_not eq valid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to new_user_session_path
          end
        end
      end
    end

    context 'When the user is signed in' do
      before(:each) { sign_in @signed_in_user }

      context 'When the article does not exist' do
        context 'With invalid arguments' do
          it do
            expect { patch article_path(0), params: { article: invalid_attributes } }.to raise_exception ActiveRecord::RecordNotFound
            patch article_path(0), params: { article: invalid_attributes }
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            # ? why redirect to the sign in page?
            # expect(response).to redirect_to new_user_session_path
          end
        end

        context 'With valid arguments' do
          it do
            expect { patch article_path(0), params: { article: valid_attributes } }.to raise_exception ActiveRecord::RecordNotFound
            patch article_path(0), params: { article: valid_attributes }
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            # ? why redirect to the sign in page?
            # expect(response).to redirect_to new_user_session_path
          end
        end
      end

      context 'When the article exists but does not belong to the user' do
        context 'With invalid arguments' do
          it do
            patch article_path(@signed_out_user_article), params: { article: invalid_attributes }
            @signed_out_user_article.reload
            expect(@signed_out_user_article.name).to_not eq invalid_attributes[:name]
            expect(@signed_out_user_article.body).to_not eq invalid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to root_path
          end
        end

        context 'With valid arguments' do
          it do
            patch article_path(@signed_out_user_article), params: { article: valid_attributes }
            @signed_out_user_article.reload
            expect(@signed_out_user_article.name).to_not eq valid_attributes[:name]
            expect(@signed_out_user_article.body).to_not eq valid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to root_path
          end
        end
      end

      context 'When the article exists and belongs to the user' do
        context 'With invalid arguments' do
          it do
            patch article_path(@signed_in_user_article), params: { article: invalid_attributes }
            @signed_in_user_article.reload
            expect(@signed_in_user_article.name).to_not eq invalid_attributes[:name]
            expect(@signed_in_user_article.body).to_not eq invalid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :unprocessable_entity
            expect(response).to render_template :edit
          end
        end

        context 'With valid arguments' do
          it do
            patch article_path(@signed_in_user_article), params: { article: valid_attributes }
            @signed_in_user_article.reload
            expect(@signed_in_user_article.name).to eq valid_attributes[:name]
            expect(@signed_in_user_article.body).to eq valid_attributes[:body]
            expect(response).to_not be_successful
            expect(response).to have_http_status :found
            expect(response).to redirect_to article_path(@signed_in_user_article)
          end
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'When the user is not signed in' do
      context 'When the article does not exist' do
        it do
          expect { delete article_path(0) }.to_not raise_error
          delete article_path(0)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect { response }.to change(Article, :count).by 0
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists but does not belong to the user' do
        it do
          delete article_path(@signed_out_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect { response }.to change(Article, :count).by 0
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists and belongs to the user' do
        it do
          delete article_path(@signed_in_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect { response }.to change(Article, :count).by 0
          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    context 'When the user is signed in' do
      before(:each) { sign_in @signed_in_user }

      context 'When the article does not exist' do
        it do
          expect { delete article_path(0) }.to raise_exception ActiveRecord::RecordNotFound
          delete article_path(0)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect { response }.to change(Article, :count).by 0
          # ? why redirect to the sign in page?
          # expect(response).to redirect_to new_user_session_path
        end
      end

      context 'When the article exists but does not belong to the user' do
        it do
          delete article_path(@signed_out_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          expect { response }.to change(Article, :count).by 0
          expect(response).to redirect_to root_path
        end
      end

      context 'When the article exists and belongs to the user' do
        it do
          delete article_path(@signed_in_user_article)
          expect(response).to_not be_successful
          expect(response).to have_http_status :found
          # ? expected `Article.count` to have changed by -1, but was changed by 0
          # expect { response }.to change(Article, :count).by -1
          expect(response).to redirect_to articles_path
        end

        it do
          expect { delete article_path(@signed_in_user_article) }.to change(Article, :count).by -1
        end
      end
    end
  end
end
