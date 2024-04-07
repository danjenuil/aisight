require 'rails_helper'

RSpec.describe 'User' do
  context 'homepage' do
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
end
