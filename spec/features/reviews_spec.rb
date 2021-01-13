# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Reviews', :js do
  scenario 'Visitor creates a new review' do
    visit '/reviews/new'

    find('.brand-select').find('input').fill_in with: "Macallan\n"
    fill_in 'Title', with: '15 Y - Triple Cask Matured'
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
      brand: 'Macallan',
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

  scenario 'Visitor can visit show page of an existing review' do
    ReviewForm.new(
      title: 'Macallan, 15 Y - Triple Cask Matured',
      brand: 'Macallan',
      description: ''"
      Aroma is not unpleasant but it’s not earth-shattering either,
      rather basic, but on the good side of basic, with its delivery of fruity and malty aromas;
      Palate is also light with malty, fruity and baked sweets notes – again,
      not bad but light and without dramtic complexity;
      Finish is soft and sweet and my favorite part of this Scotch.
     "'',
      taste_grade: 5,
      color_grade: 4,
      smokiness_grade: 3
    ).submit

    visit '/reviews'

    page.find('td', text: 'Macallan, 15 Y - Triple Cask Matured').click
    expect(page).to have_content('Aroma is not unpleasant but')
  end

  scenario 'Visitor can search in existing reviews' do
    ReviewForm.new(
      title: 'Macallan 15 Y - Triple Cask Matured',
      brand: 'Macallan',
      description: 'Aroma is not unpleasant but it’s not earth-shattering either.',
      taste_grade: 5,
      color_grade: 4,
      smokiness_grade: 3
    ).submit

    ReviewForm.new(
      title: 'Glenfiddich 12Y',
      brand: 'Glenfiddich',
      description: 'Finish is soft and sweet and my favorite part of this Scotch.',
      taste_grade: 5,
      color_grade: 4,
      smokiness_grade: 3
    ).submit

    visit '/reviews'

    fill_in 'search-form', with: 'Macalla'
    expect(page).to have_content('Macallan 15 Y - Triple Cask Matured')
    expect(page).not_to have_content('Glenfiddich 12Y')

    fill_in 'search-form', with: 'Finish'
    expect(page).not_to have_content('Macallan 15 Y - Triple Cask Matured')
    expect(page).to have_content('Glenfiddich 12Y')
  end

  scenario 'Visitor can paginate through reviews' do
    38.times do
      ReviewForm.new(
        title: FFaker::Book.title,
        brand: %w[Macallan Glenfiddich Glenlivit Bowmore].sample,
        description: FFaker::HipsterIpsum.sentences,
        taste_grade: rand(1..5),
        color_grade: rand(1..5),
        smokiness_grade: rand(1..5)
      ).submit
    end

    visit '/reviews'
    expect(page).to have_content('Showing 10 of ~38 results')
    expect(page).to have_content('Page 1 of 4')
    first_title = page.find(:xpath, '//table/tbody/tr/td', match: :first).text
    page.find('button', text: '>', match: :prefer_exact).click

    expect(page).to have_content('Showing 10 of ~38 results')
    expect(page).to have_content('Page 2 of 4')
    second_title = page.find(:xpath, '//table/tbody/tr/td', match: :first).text

    expect(first_title).not_to eq(second_title)
  end
end
