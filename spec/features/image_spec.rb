require 'rails_helper'
require 'faker'

RSpec.describe 'Image' do
  before do
    Faker::Config.random = Random.new(10)
    # create user and corresponding images (25 of them), using FactoryBot
    @user = FactoryBot.create(:user)

    25.times do
      FactoryBot.create(:image, title: Faker::Address.city,  user: @user)
    end

    sign_in @user
    visit '/images'
  end

  it 'allows user to see a list of uploaded images' do
    expect(page).to have_text('Images')
    within('table') do
      expect(page).to have_selector('tr', count: 26) # 25 images + 1 header row
    end
  end

  it 'allows user to see individual image on its own page' do
    # Assuming the 2nd cell in the first row triggers the action
    within('table tbody tr:first-child') do
      find('td:last-child').click_link('View')
    end

    expect(current_path).to match(/images\/\d+/)
    expect(page).to have_text('Images / Lake Tyson')
    expect(page).to have_link('Edit')
    expect(page).to have_link('Delete')
  end
end
