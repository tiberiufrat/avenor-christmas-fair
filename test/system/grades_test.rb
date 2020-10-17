require "application_system_test_case"

class GradesTest < ApplicationSystemTestCase
  setup do
    @grade = grades(:one)
  end

  test "visiting the index" do
    visit grades_url
    assert_selector "h1", text: "Grades"
  end

  test "creating a Grade" do
    visit grades_url
    click_on "New Grade"

    fill_in "Name", with: @grade.name
    click_on "Create Grade"

    assert_text "Grade was successfully created."
    click_on "Back"
  end

  test "updating a Grade" do
    visit grades_url
    click_on "Edit it", match: :first

    fill_in "Name", with: @grade.name
    click_on "Update Grade"

    assert_text "Grade was successfully updated."
    click_on "Back"
  end

  test "destroying a Grade" do
    visit grades_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Grade was successfully destroyed."
  end
end
