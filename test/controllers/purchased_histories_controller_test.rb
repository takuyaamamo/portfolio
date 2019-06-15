require 'test_helper'

class PurchasedHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchased_history = purchased_histories(:one)
  end

  test "should get index" do
    get purchased_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_purchased_history_url
    assert_response :success
  end

  test "should create purchased_history" do
    assert_difference('PurchasedHistory.count') do
      post purchased_histories_url, params: { purchased_history: { address: @purchased_history.address, created_at: @purchased_history.created_at, email_address: @purchased_history.email_address, phone_number: @purchased_history.phone_number, postal_code: @purchased_history.postal_code, shipping: @purchased_history.shipping, updated_at: @purchased_history.updated_at, user_name: @purchased_history.user_name } }
    end

    assert_redirected_to purchased_history_url(PurchasedHistory.last)
  end

  test "should show purchased_history" do
    get purchased_history_url(@purchased_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchased_history_url(@purchased_history)
    assert_response :success
  end

  test "should update purchased_history" do
    patch purchased_history_url(@purchased_history), params: { purchased_history: { address: @purchased_history.address, created_at: @purchased_history.created_at, email_address: @purchased_history.email_address, phone_number: @purchased_history.phone_number, postal_code: @purchased_history.postal_code, shipping: @purchased_history.shipping, updated_at: @purchased_history.updated_at, user_name: @purchased_history.user_name } }
    assert_redirected_to purchased_history_url(@purchased_history)
  end

  test "should destroy purchased_history" do
    assert_difference('PurchasedHistory.count', -1) do
      delete purchased_history_url(@purchased_history)
    end

    assert_redirected_to purchased_histories_url
  end
end
