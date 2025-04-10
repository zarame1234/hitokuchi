

bob = User.find_or_create_by!(email: "bob@example.com") do |user|
  user.name = "bob"
  user.password = "password"
  user.introduction = "出張先での食べ歩き記録"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

lucy = User.find_or_create_by!(email: "lucy@example.com") do |user|
  user.name = "lucy"
  user.password = "password"
  user.introduction = "関東を中心に記録を載せています！"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "lucas"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end


post1 = Post.find_or_create_by!(shop_name: "おでん屋台") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.body = "たまたま見つけた屋台。いい香り。"
  post.user = bob
  post.address = "東京都千代田区大手町2丁目2-1"
  
end

post2 = Post.find_or_create_by!(shop_name: "洋菓子屋") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.body = "甘いものが食べたくなり購入"
  post.user = lucy
  post.address = "東京都千代田区大手町2丁目6"

end

post3 = Post.find_or_create_by!(shop_name: "ハンバーガー屋") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.body = '満足感がすごい！'
  post.user = lucas
  post.address = "東京都中央区八重洲2丁目8"
end

post4 = Post.find_or_create_by!(shop_name: "たい焼き") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
  post.body = 'あんこがずっしり！'
  post.user = lucas
  post.address = "東京都江東区豊洲6丁目5-1"
end

comment1 = post1.post_comments.create(comment: "ここのおでんは絶品ですね！", user: lucy)
comment2 = post1.post_comments.create(comment: "食べてみたいです！", user: lucas)
comment3 = post4.post_comments.create(comment: "いい香りがしそうですね", user: bob)

favorite1 = post2.favorites.create(user: bob)
favorite2 = post2.favorites.create(user: lucy)
favorite3 = post3.favorites.create(user: lucy)


admin = Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
end