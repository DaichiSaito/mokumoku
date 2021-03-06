module ApplicationHelper
  require 'uri'
  def escape_with_linefeed(text, link: false)
    if link
      simple_format(text_url_to_link(text))
    else
      simple_format(h(text))
    end
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

  def text_url_to_link text
    URI.extract(text, ['http','https'] ).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=\"" << url << "\" target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    return text
  end

  def default_meta_tags
    {
        site: Settings.common.app.name,
        reverse: true,
        title: Settings.common.app.page_title,
        description: Settings.common.app.page_description,
        keywords: Settings.common.app.page_keywords,
        canonical: request.original_url,
        separator: '|'
    }
  end
end
