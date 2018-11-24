10.times { |n|
  email = "test#{n}@g.com"
  next if User.find_by(email: email)
  User.seed do |u|
    n = n + 1
    u.name = "#{n}番目のユーザー"
    u.screen_name = "#{Settings.twitter.account_name}"
    u.profile = "#{n}番目のユーザーのプロフィール"
    u.email = email
    u.crypted_password = User.encrypt('foobar')
  end
}
