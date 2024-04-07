require 'rails_helper'

RSpec.describe 'Image' do
  before do
    # create user and corresponding images (25 of them), using FactoryBot
    @user = FactoryBot.create(:user)

    25.times do
      FactoryBot.create(:image, user: @user)
    end
  end

  it 'allows user to see a list of uploaded images' do
    sign_in @user
    visit "/images"
    expect(page).to have_text('Images')
    within('table') do
      expect(page).to have_selector('tr', count: 26) # 25 images + 1 header row
    end
  end
end
