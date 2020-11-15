require "application_system_test_case"

class NotificationsTest < ApplicationSystemTestCase
  setup do
    @notification = notifications(:one)
  end

  test "visiting the index" do
    visit notifications_url
    assert_selector "h1", text: "Notifications"
  end

  test "creating a Notification" do
    visit notifications_url
    click_on "New Notification"

    fill_in "Admin", with: @notification.admin_id
    fill_in "Color", with: @notification.color
    fill_in "Icon", with: @notification.icon
    fill_in "Link", with: @notification.link
    fill_in "Text", with: @notification.text
    click_on "Create Notification"

    assert_text "Notification was successfully created."
    click_on "Back"
  end

  test "updating a Notification" do
    visit notifications_url
    click_on "Edit it", match: :first

    fill_in "Admin", with: @notification.admin_id
    fill_in "Color", with: @notification.color
    fill_in "Icon", with: @notification.icon
    fill_in "Link", with: @notification.link
    fill_in "Text", with: @notification.text
    click_on "Update Notification"

    assert_text "Notification was successfully updated."
    click_on "Back"
  end

  test "destroying a Notification" do
    visit notifications_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Notification was successfully destroyed."
  end
end
