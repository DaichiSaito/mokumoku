module ApplicationHelper
  def escape_with_linefeed(text)
    simple_format(h(text))
  end

  def sns_share_url_with_message(message, sub_url)
    "#{Settings.twitter.share_url}" \
    "?text=#{message}%0A" \
    "&hashtags=#{Settings.twitter.hashtag}" \
    "&url=#{Settings.common.app.og.url}#{sub_url}"
  end

  def sns_account_url(sub_url)
    "#{Settings.twitter.url}/#{sub_url}"
  end
end
