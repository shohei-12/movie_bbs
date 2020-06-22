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

# posts
30.times do |n|
  title = "テスト#{n + 1}"
  content = "テスト投稿#{n + 1}です。"
  Post.create!(
    title: title,
    content: content,
    user_id: 1
  )
end
