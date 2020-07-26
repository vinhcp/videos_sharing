require 'rails_helper'

describe 'A guest user ' do
  let(:user) { build(:user) }

  context 'when having no email' do
    it 'should have an error message' do
      login_user
      expect(page).to have_content 'Email can\'t be blank'
    end
  end

  context 'when having email but no password' do
    it 'should have an error message' do
      login_user(user: user, password: '')
      expect(page).to have_content 'Password can\'t be blank'
      expect(page).to have_selector("input[value='#{user.email}']")
    end
  end

  context 'when having email but password is shorter 6 characters' do
    it 'should have an error message' do
      login_user(user: user, password: '123')
      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
      expect(page).to have_selector("input[value='#{user.email}']")
    end
  end

  context 'when having valid email and passwod' do
    it 'sign up successfully' do
      login_user(user: user)
      expect(page).to have_content 'Welcome! You have signed up successfully.'
      expect(page).to have_content "Welcome #{user.email}"
      expect(page).to have_link(href: destroy_user_session_path)
    end
  end
end
