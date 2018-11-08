10.times { |n|
  User.seed do |u|
    n = n + 1
    u.name = "#{n}番目のユーザー"
    u.profile = "#{n}番目のユーザーのプロフィール"
    u.email = "test#{n}@g.com"
    u.salt = "asdasdastr4325234324sdfds"
    u.crypted_password = Sorcery::CryptoProviders::BCrypt.encrypt("foobar", "asdasdastr4325234324sdfds")
  end
}
