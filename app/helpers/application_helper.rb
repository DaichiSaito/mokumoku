module ApplicationHelper
  def sns_share_url_with_message(message, sub_url)
    "#{Settings.twitter.share_url}" \
    "?text=#{message}%0A" \
    "&url=#{Settings.common.app.og.url}#{sub_url}"
  end

  def sns_account_url(sub_url)
    "#{Settings.twitter.url}/#{sub_url}"
  end
end
