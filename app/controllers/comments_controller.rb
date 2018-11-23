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
      @mokumoku.notifications.create(user_id: @mokumoku.user.id, notified_by: current_user, notified_type: :commented_to_own_mokumoku)
      NotificationMailer.send_mokumoku_owner(@mokumoku.user, @mokumoku).deliver_later
      @mokumoku.participants.each do |user|
        @mokumoku.notifications.create(user_id: user.id, notified_by: @mokumoku.user, notified_type: :commented_to_attending_mokumoku)
        NotificationMailer.send_mokumoku_participants(user, @mokumoku).deliver_later
      end
    end
end
