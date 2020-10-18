require "application_system_test_case"

class VolunteersTest < ApplicationSystemTestCase
  setup do
    @volunteer = volunteers(:one)
  end

  test "visiting the index" do
    visit volunteers_url
    assert_selector "h1", text: "Volunteers"
  end

  test "creating a Volunteer" do
    visit volunteers_url
    click_on "New Volunteer"

    fill_in "Department", with: @volunteer.department_id
    fill_in "Email", with: @volunteer.email
    fill_in "First name", with: @volunteer.first_name
    fill_in "Grade", with: @volunteer.grade_id
    fill_in "Job", with: @volunteer.job_id
    fill_in "Last name", with: @volunteer.last_name
    fill_in "Phone", with: @volunteer.phone
    fill_in "Stand", with: @volunteer.stand_id
    click_on "Create Volunteer"

    assert_text "Volunteer was successfully created."
    click_on "Back"
  end

  test "updating a Volunteer" do
    visit volunteers_url
    click_on "Edit it", match: :first

    fill_in "Department", with: @volunteer.department_id
    fill_in "Email", with: @volunteer.email
    fill_in "First name", with: @volunteer.first_name
    fill_in "Grade", with: @volunteer.grade_id
    fill_in "Job", with: @volunteer.job_id
    fill_in "Last name", with: @volunteer.last_name
    fill_in "Phone", with: @volunteer.phone
    fill_in "Stand", with: @volunteer.stand_id
    click_on "Update Volunteer"

    assert_text "Volunteer was successfully updated."
    click_on "Back"
  end

  test "destroying a Volunteer" do
    visit volunteers_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Volunteer was successfully destroyed."
  end
end
