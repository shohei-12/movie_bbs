# main user
User.create!(
  name: '前田 翔平',
  email: 'maeda@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

# 99 sub users
99.times do |n|
  name = Gimei.unique.name.kanji
  email = "example-#{n + 1}@gmail.com"
  password = 'password'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

# category
Category.create!(
  name: 'チャレンジ系'
)

Category.create!(
  name: 'ゲーム実況'
)

Category.create!(
  name: '音楽系'
)

Category.create!(
  name: '料理・グルメ系'
)

Category.create!(
  name: 'その他'
)

# posts
30.times do |n|
  url = 'TQ8WlA2GXbk'
  content = "テスト投稿#{n + 1}です。"
  Post.create!(
    url: url,
    content: content,
    user_id: 1,
    category_id: 1
  )
end
