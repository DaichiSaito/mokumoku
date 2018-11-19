module ApplicationHelper
  def sns_share_url_with_message(message)
    "#{Settings.twitter.share_url}" \
    "?text=#{message}%0A" \
    "&url=#{Settings.common.app.url}"
  end
end
