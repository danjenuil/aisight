require 'rails_helper'
require 'faker'

RSpec.describe 'Image' do
  before(:all) do
    Faker::Config.random = Random.new(10)
    @user = FactoryBot.create(:user)
    # create user and corresponding images (25 of them), using FactoryBot
    25.times do
      FactoryBot.create(:image, title: Faker::Address.city,  user: @user)
    end
  end

  before(:each) do
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
    expect(page).to have_text('Images / Aracelystad')
    expect(page).to have_link('Edit')
    expect(page).to have_link('Delete')
  end

  it 'allows user to delete an image' do
    # Assuming the 2nd cell in the first row triggers the action
    within('table tbody tr:first-child') do
      find('td:last-child').click_link('Delete')
    end

    expect(page).to have_text('Image was successfully destroyed.')
    within('table') do
      expect(page).to have_selector('tr', count: 25) # 25 images + 1 header row
    end
  end

  it 'allows user to upload an image' do
    click_link 'Upload an Image'
    expect(current_path).to eq('/images/new')

    fill_in 'Title', with: Faker::Address.city
    attach_file 'image[file]', Rails.root.join('spec', 'support', 'sample_image.jpg')
    click_button 'Create Image'

    expect(current_path).to match(/images\/\d+/)
    expect(page).to have_text('Image was successfully uploaded.')
    expect(find('div.image-tags')).to have_selector('a.image-tag', minimum: 1)
  end
end
