require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:one)
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "creating a Item" do
    visit items_url
    click_on "New Item"

    fill_in "Item active", with: @item.item_active
    fill_in "Item description", with: @item.item_description
    fill_in "Item image", with: @item.item_image_id
    fill_in "Item name", with: @item.item_name
    fill_in "Item price", with: @item.item_price
    fill_in "Item qr", with: @item.item_qr
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    visit items_url
    click_on "Edit", match: :first

    fill_in "Item active", with: @item.item_active
    fill_in "Item description", with: @item.item_description
    fill_in "Item image", with: @item.item_image_id
    fill_in "Item name", with: @item.item_name
    fill_in "Item price", with: @item.item_price
    fill_in "Item qr", with: @item.item_qr
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    visit items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item was successfully destroyed"
  end
end
