require 'rails_helper'

RSpec.describe Auth::SessionsController do
  let(:user) { create(:user) }

  describe 'POST create' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'enter existing email but password is empty or invalid' do
      it 'should have notice and redirects to homepage' do
        post 'create', params: { user: { email: user.email, password: '123' } }
        expect(response).to redirect_to(root_path)
        expect(controller.current_user).to be_nil
      end
    end

    context 'enter existing valid email and password' do
      it 'sign in and redirect to homepage' do
        post 'create', params: { user: { email: user.email, password: user.password } }
        expect(response).to redirect_to(root_path)
        expect(controller.current_user).to eq(user)
      end
    end

    context 'enter new email but password is empty or invalid' do
      it 'should have notice and redirects to homepage' do
        post 'create', params: { user: { email: 'new@new.com', password: '123' } }
        expect(response).to redirect_to(root_path)
        expect(controller.current_user).to be_nil
      end
    end

    context 'enter new valid email and password' do
      it 'sign up and redirect to homepage' do
        expect do
          post 'create', params: { user: { email: 'new@new.com', password: '123123' } }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
        expect(controller.current_user.email).to eq('new@new.com')
      end
    end
  end
end
