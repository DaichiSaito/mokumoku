class NotificationMailer < ApplicationMailer
  default from: Settings.common.app.mail.from
  def send_favorite_areas_user(user, mokumoku)
    @mokumoku = mokumoku
    mail(to: user.email, subject: 'あなたのよく行くエリアのもくもくが投稿されました。')
  end

  def send_mokumoku_owner(user, mokumoku)
    @mokumoku = mokumoku
    mail(to: user.email, subject: 'あなたのもくもくにコメントがありました。')
  end

  def send_mokumoku_participants(user, mokumoku)
    @mokumoku = mokumoku
    mail(to: user.email, subject: 'あなたの参加予定のもくもくにコメントがありました。')
  end
end
