require "application_system_test_case"

class PurchasedHistoriesTest < ApplicationSystemTestCase
  setup do
    @purchased_history = purchased_histories(:one)
  end

  test "visiting the index" do
    visit purchased_histories_url
    assert_selector "h1", text: "Purchased Histories"
  end

  test "creating a Purchased history" do
    visit purchased_histories_url
    click_on "New Purchased History"

    fill_in "Address", with: @purchased_history.address
    fill_in "Created at", with: @purchased_history.created_at
    fill_in "Email address", with: @purchased_history.email_address
    fill_in "Phone number", with: @purchased_history.phone_number
    fill_in "Postal code", with: @purchased_history.postal_code
    fill_in "Shipping", with: @purchased_history.shipping
    fill_in "Updated at", with: @purchased_history.updated_at
    fill_in "User name", with: @purchased_history.user_name
    click_on "Create Purchased history"

    assert_text "Purchased history was successfully created"
    click_on "Back"
  end

  test "updating a Purchased history" do
    visit purchased_histories_url
    click_on "Edit", match: :first

    fill_in "Address", with: @purchased_history.address
    fill_in "Created at", with: @purchased_history.created_at
    fill_in "Email address", with: @purchased_history.email_address
    fill_in "Phone number", with: @purchased_history.phone_number
    fill_in "Postal code", with: @purchased_history.postal_code
    fill_in "Shipping", with: @purchased_history.shipping
    fill_in "Updated at", with: @purchased_history.updated_at
    fill_in "User name", with: @purchased_history.user_name
    click_on "Update Purchased history"

    assert_text "Purchased history was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchased history" do
    visit purchased_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchased history was successfully destroyed"
  end
end
