require 'rails_helper'

RSpec.describe 'User' do
  context 'homepage' do
    context 'when user is not signed in' do
      before do
        visit '/'
      end

      it 'display link to sign into AiSight' do
        expect(page).to have_text('Sign in to AiSight')
        expect(page).to have_field('user[email]')
        expect(page).to have_field('user[password]')
        expect(page).to have_button('Sign In')
      end
    end

    context 'when user is signed in' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
        visit '/'
      end

      it 'redirects to images page' do
        expect(current_path).to eq('/images')
      end
    end
  end
end
