require 'acceptance_helper'

feature "Landing Page" do
  let!(:lists) do
    List.create!([
      { name: "Quick-List Features Current Sprint" }
    ])
  end

  scenario "shows all todo lists", :js => true do
    visit '/'
    page.should have_content('Welcome to Quick-List')

    page.should have_content(lists.first.name)
    page.should have_content('Open Items')
    page.should have_content('Closed Items')

    click_link lists.first.name

    page.should have_content "Edit: #{lists.first.name}"
    current_url.should =~ /#\/lists\/#{lists.first.id.to_s}/
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

  scenario "destroy existing list", :js => true do
    visit '/'

    find('tr', text: lists.last.name).tap do |row|
      row.find_link("Delete").click
    end

    List.all.should be_empty

    page.should_not have_content(lists.first.name)
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

    list = List.create!({ name: "A pushed list" })

    PushNotification.publish "lists", "created", list.to_json

    within "table#lists" do
      page.should have_content "A pushed list"
    end
  end
end
