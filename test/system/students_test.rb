require "application_system_test_case"

class StudentsTest < ApplicationSystemTestCase
  setup do
    @student = students(:one)
  end

  test "visiting the index" do
    visit students_url
    assert_selector "h1", text: "Students"
  end

  test "creating a Student" do
    visit students_url
    click_on "New Student"

    fill_in "Balance", with: @student.balance
    fill_in "First name", with: @student.first_name
    fill_in "Grade", with: @student.grade_id
    fill_in "Last name", with: @student.last_name
    click_on "Create Student"

    assert_text "Student was successfully created."
    click_on "Back"
  end

  test "updating a Student" do
    visit students_url
    click_on "Edit it", match: :first

    fill_in "Balance", with: @student.balance
    fill_in "First name", with: @student.first_name
    fill_in "Grade", with: @student.grade_id
    fill_in "Last name", with: @student.last_name
    click_on "Update Student"

    assert_text "Student was successfully updated."
    click_on "Back"
  end

  test "destroying a Student" do
    visit students_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Student was successfully destroyed."
  end
end
