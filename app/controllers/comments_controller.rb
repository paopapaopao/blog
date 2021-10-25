class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to article_path(@article), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
