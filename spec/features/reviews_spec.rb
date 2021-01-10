require 'rails_helper'

RSpec.feature "Reviews" do
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
      within('#taste'){ choose option: 3 }
      within('#color'){ choose option: 2 }
      within('#smokiness'){ choose option: 4 }
      
      click_button 'Submit'
  
      expect(page).to have_text('Thank you for creating a review')
    end
end