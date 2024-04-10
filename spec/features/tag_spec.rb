require 'rails_helper'

RSpec.describe 'Tag' do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    sign_in user
  end

  context 'index page' do
    it 'list all of the tags that the user have' do
      tag_names = ['House', 'Glass', 'Sky']
      tag_names.each_with_index do |tag_name, index|
        FactoryBot.create(:tag, name: tag_name, images: FactoryBot.create_list(:image, index + 1, user: user))
      end


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
          expect(find('tr:nth-child(3) td:nth-child(2)')).to have_text '3'
        end
      end
    end
  end

  context 'show page' do
    it 'show all images that have the same tag' do
      tag = FactoryBot.create(:tag, name: 'House', images: FactoryBot.create_list(:image, 3, user: user))
      visit "/tags/#{tag.id}"
      expect(page).to have_text('Tags / House')
      within('table') do
        expect(page).to have_selector('tr', count: 4) # 3 images + 1 header row
      end
    end
  end
end