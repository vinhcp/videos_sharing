require 'rails_helper'

describe 'A guest user' do
  let(:user) { create(:user) }

  context 'enter existing email but password is empty or invalid' do
    it 'should have notice message' do
      login_user(user: user, password: '123')
      expect(page).to have_content 'Invalid Email or password.'
      expect(page).to have_selector("input[value='Login / Register']")
      expect(page).to have_selector("input[value='#{user.email}']")
    end
  end

  context 'enter valid email and password' do
    it 'sign in successfully' do
      login_user(user: user)
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content "Welcome #{user.email}"
      expect(page).to have_link(href: destroy_user_session_path)
    end
  end
end
