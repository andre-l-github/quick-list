require 'acceptance_helper'

feature "Landing Page" do

  let(:list_name) { "Quick-List Features Current Sprint" }

  scenario "shows all todo lists", :js => true do
    visit '/'
    page.should have_content('Welcome to Quick-List')

    page.should have_content(list_name)
    page.should have_content('Open Items')
    page.should have_content('Closed Items')

    click_link list_name

    page.should have_content "Edit: #{list_name}"
    current_url.should =~ /#\/lists\/1/
  end

  scenario "create new list", :js => true do
    visit '/'

    fill_in "listName", with: "Awesome new list"
    click_button "Add"

    within "table#lists" do
      page.should have_content "Awesome new list"
    end

    find_field("listName").value.should be_empty
  end

  scenario "update lists from push notification", :js => true do
    visit "/"

    # Make sure that the page is actually loaded before
    # shooting off the notification. Otherwise, you're gonna
    # run into a race condition here.
    page.should have_content('Welcome to Quick-List')

    within "table#lists" do
      page.should_not have_content "A pushed list"
    end

    PushNotification.publish "lists", "created", { id: 2, name: "A pushed list", open: 0, closed: 1 }

    within "table#lists" do
      page.should have_content "A pushed list"
    end
  end
end
