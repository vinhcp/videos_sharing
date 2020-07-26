module Features
  module LoginHelpers
    def login_user(user: nil, password: nil)
      visit root_path
      within('form#new_user') do
        fill_in 'user_email', with: user.try(:email)
        fill_in 'user_password', with: password || user.try(:password)
      end
      click_button 'Login / Register'
    end
  end
end
