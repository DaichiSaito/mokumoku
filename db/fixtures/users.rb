10.times { |n|
  User.seed do |u|
    n = n + 1
    u.name = "#{n}番目のユーザー"
    u.profile = "#{n}番目のユーザーのプロフィール"
    u.email = "test#{n}@g.com"
    u.crypted_password = User.encrypt('foobar')
  end
}
