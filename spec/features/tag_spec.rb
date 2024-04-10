require 'rails_helper'

RSpec.describe 'Tag' do

  context 'index page' do
    tag_names = ['House', 'Glass', 'Sky']

    user = FactoryBot.create(:user)
    tag_names.each_with_index do |tag_name, index|
      FactoryBot.create(:tag, name: tag_name, images: FactoryBot.create_list(:image, index + 1, user: user))
    end

    sign_in user
    visit '/tags'

    expect(page).to have_text('Tags')
    within('table') do
      expect(page).to have_selector('tr', count: 4) # 3 tags + 1 header row
      within('tbody') do
        expect(find('tr:nth-child(1) td:nth-child(1)')).to have_text 'House'
        expect(find('tr:nth-child(2) td:nth-child(1)')).to have_text 'Glass'
        expect(find('tr:nth-child(3) td:nth-child(1)')).to have_text 'Sky'

        expect(find('tr:nth-child(1) td:nth-child(2)')).to have_text '1'
        expect(find('tr:nth-child(2) td:nth-child(2)')).to have_text '2'
        expect(find('tr:nth-child(3) td:nth-child(2)')).to have_text '2'
      end
    end
  end
end