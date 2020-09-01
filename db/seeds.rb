50.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: Faker::Internet.user_name,
    password: "password",
    genre: User.genre.values.sample,
    pref1: User.pref1.values.sample,
    team_name: "ダンスチーム#{n + 1}",
    carrer: "実績#{n + 1}",
    lesson_comment: "レッスンコメント#{n + 1}",
    movie_url: "https://www.youtube.com/watch?v=lAqvUJqfjds",
    twitter_url: "@mattsun_PTN",
    instagram_url: "aj76619",
    promotion_title: "公式HP",
    promotion_url: "http://www.studio-ash.com/",
    created_at: '2020-04-30 12:00:01.139093',
    updated_at: '2020-04-30 12:00:01.139093',
  )
end

User.all.each do |user|
  user.announcements.create!(
    content: "今日のレッスンはお休みです！",
    created_at: Time.zone.now
  )
end

users = User.all
user  = users.first
followers = users[2..50]
followings = users[3..40]
followers.each { |followed| user.follow(followed) }
followings.each { |follower| follower.follow(user) }