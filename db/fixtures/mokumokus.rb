30.times { |n|
  Mokumoku.seed do |m|
    n = n + 1
    m.title = "#{n}番目のもくもく"
    m.body = "もくもくサンプルだよ"
    m.user_id = 1
    m.area_id = 1
    m.open_at = Time.current
  end
}
