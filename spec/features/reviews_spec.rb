# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Reviews', :js do
  scenario 'Visitor creates a new review' do
    visit '/reviews/new'

    fill_in 'Title', with: 'Macallan, 15 Y - Triple Cask Matured'
    fill_in 'Description', with: ''"
        Aroma is not unpleasant but it’s not earth-shattering either,
        rather basic, but on the good side of basic, with its delivery of fruity and malty aromas;
        Palate is also light with malty, fruity and baked sweets notes – again,
        not bad but light and without dramtic complexity;
        Finish is soft and sweet and my favorite part of this Scotch.
       "''

    within('#taste_grade') { page.find('#taste_grade3').click }
    within('#color_grade') { page.find('#color_grade2').click }
    within('#smokiness_grade') { page.find('#smokiness_grade4').click }

    click_button 'Submit'
    expect(page).to have_text('Thank you for creating a review')
  end

  scenario 'Visitor can see existing reviews' do
    ReviewForm.new(
      title: 'Macallan, 15 Y - Triple Cask Matured',
      description: 'description',
      taste_grade: 5,
      color_grade: 4,
      smokiness_grade: 3
    ).submit

    visit '/reviews'
    
    expect(page).to have_content('Showing 1 of ~1 results')
    expect(page).to have_content('Macallan, 15 Y - Triple Cask Matured')
    expect(page).to have_content(5)
  end


  scenario 'Visitor can paginate through reviews' do
    38.times do 
      ReviewForm.new(
        title: FFaker::Book.title,
        description: FFaker::HipsterIpsum.sentences,
        taste_grade: rand(1..5),
        color_grade: rand(1..5),
        smokiness_grade: rand(1..5)
      ).submit
    end

    visit '/reviews'
    expect(page).to have_content('Showing 20 of ~38 results')
    expect(page).to have_content('Page 1 of 2')
    first_title = page.find(:xpath, '//table/tbody/tr/td', match: :first).text
    page.find('button', text: '>', match: :prefer_exact).click

    expect(page).to have_content('Showing 18 of ~38 results')
    expect(page).to have_content('Page 2 of 2')
    second_title = page.find(:xpath, '//table/tbody/tr/td', match: :first).text

    expect(first_title).not_to eq(second_title)
  end
end
