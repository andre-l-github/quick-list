require 'acceptance_helper'

feature "Landing Page" do

  scenario "shows all todo lists", :js => true do
    visit '/'
    page.should have_content('Welcome to Quick-List')

    page.should have_content('Quick-List Features Current Sprint')
  end
end