require 'rails_helper'

describe 'A logged-in user' do
  let(:user) { create(:user) }
  context 'is clicking Logout' do
    it 'sign out successfully' do
      login_user(user: user)
      click_on('Logout')
      expect(page).to have_content('Signed out successfully.')
      expect(page).to have_selector("input[value='Login / Register']")
    end
  end
end
