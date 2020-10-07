def log_in_as(user)
  visit new_user_session_path
  fill_in 'メールアドレス', with: user.email
  fill_in 'password', with: user.password
  click_button 'ログイン'
end

def log_out
  visit root_path
  find(".dropdown").click
  click_on 'ログアウト'
end