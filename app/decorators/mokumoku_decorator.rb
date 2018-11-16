class MokumokuDecorator < ApplicationDecorator
  delegate_all

  def share_message
    "タイトル　　　　：#{title}%0A" \
    "もくもく予定日時：#{open_at.to_s(:datetime)}%0A" \
    "エリア　　　　　：#{area.name}"
  end
end
