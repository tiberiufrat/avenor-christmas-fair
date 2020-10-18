require "application_system_test_case"

class StandsTest < ApplicationSystemTestCase
  setup do
    @stand = stands(:one)
  end

  test "visiting the index" do
    visit stands_url
    assert_selector "h1", text: "Stands"
  end

  test "creating a Stand" do
    visit stands_url
    click_on "New Stand"

    fill_in "Name", with: @stand.name
    click_on "Create Stand"

    assert_text "Stand was successfully created."
    click_on "Back"
  end

  test "updating a Stand" do
    visit stands_url
    click_on "Edit it", match: :first

    fill_in "Name", with: @stand.name
    click_on "Update Stand"

    assert_text "Stand was successfully updated."
    click_on "Back"
  end

  test "destroying a Stand" do
    visit stands_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Stand was successfully destroyed."
  end
end
