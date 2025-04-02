bob = User.find_or_create_by!(email: "bob@example.com") do |user|
  user.name = "bob"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

lucy = User.find_or_create_by!(email: "lucy@example.com") do |user|
  user.name = "lucy"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "lucas"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

Post.find_or_create_by!(shop_name: "おでん屋台") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.body = "たまたま見つけた屋台。"
  post.user = bob
  post.address = "京都府京都市南区鳥羽北村山町2"
end

Post.find_or_create_by!(shop_name: "洋菓子屋") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.body = "甘いものが食べたくなり購入"
  post.user = lucy
  post.address = "東京都千代田区大手町2丁目6"
end

Post.find_or_create_by!(shop_name: "ハンバーガー屋") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.body = '腹持ちがいい！'
  post.user = lucas
  post.address = "静岡県富士市前田地先"
end

admin = Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
end