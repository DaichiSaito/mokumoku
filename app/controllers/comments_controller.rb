class CommentsController < ApplicationController
  before_action :require_login
  after_action :create_notifications, only: [:create]
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

    def create_notifications
      return unless @comment.persisted?
      @mokumoku.notifications.create(user_id: @mokumoku.user.id, body: 'あなたのもくもくにコメントがありました。')
      @mokumoku.participants.each do |user|
        @comment.notifications.create(user_id: user.id, body: 'あなたの参加予定のもくもくにコメントがありました。')
      end
    end
end
