class CommentsController < ApplicationController
  def create
    @mokumoku = Mokumoku.find(params[:mokumoku_id])
    @comment = Comment.new(comment_params)
    current_user.post_comment(@mokumoku, @comment)
    redirect_to mokumoku_path(@mokumoku)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to mokumoku_path(@comment.mokumoku)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
