require 'rails_helper'

RSpec.describe "contestants index page" do 
  describe 'when I visit the contestants index page' do 
    it 'shows a list of all contestant names' do 
      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

      visit "/contestants"

      expect(page).to have_content(jay.name)
      expect(page).to have_content(gretchen.name)
      expect(page).to have_content(kentaro.name)
    end 

    it 'has the name of all the projects each contestant has been on' do 
      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
      lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: jay.id, project_id: lit_fit.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: boardfit.id)

      visit '/contestants'

      expect(page).to have_content("Project: #{news_chic.name}")
      expect(page).to have_content("Project: #{lit_fit.name}")
      expect(page).to have_content("Project: #{boardfit.name}")
      expect(page).to_not have_content("Project: #{upholstery_tux.name}")
    end 
  end 
end 