require 'rails_helper'

RSpec.feature "Reviews", :js do
    scenario "Visitor creates a new review" do
      visit "/reviews/new"

      fill_in 'Title', with: 'Macallan, 15 Y - Triple Cask Matured'
      fill_in 'Description', with: """
        Aroma is not unpleasant but it’s not earth-shattering either, 
        rather basic, but on the good side of basic, with its delivery of fruity and malty aromas; 
        Palate is also light with malty, fruity and baked sweets notes – again, 
        not bad but light and without dramtic complexity; 
        Finish is soft and sweet and my favorite part of this Scotch.
       """

      within('#taste_grade'){ page.find('#taste_grade3').click() }
      within('#color_grade'){ page.find('#color_grade2').click()  }
      within('#smokiness_grade'){ page.find('#smokiness_grade4').click()  }
      
      click_button 'Submit'
      expect(page).to have_text('Thank you for creating a review')
    end
end