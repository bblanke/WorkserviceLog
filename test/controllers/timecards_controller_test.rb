require 'test_helper'

class TimecardsControllerTest < ActionController::TestCase
  setup do
    @timecard = timecards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timecards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timecard" do
    assert_difference('Timecard.count') do
      post :create, timecard: { timein: @timecard.timein, timeout: @timecard.timeout, user_id: @timecard.user_id }
    end

    assert_redirected_to timecard_path(assigns(:timecard))
  end

  test "should show timecard" do
    get :show, id: @timecard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @timecard
    assert_response :success
  end

  test "should update timecard" do
    patch :update, id: @timecard, timecard: { timein: @timecard.timein, timeout: @timecard.timeout, user_id: @timecard.user_id }
    assert_redirected_to timecard_path(assigns(:timecard))
  end

  test "should destroy timecard" do
    assert_difference('Timecard.count', -1) do
      delete :destroy, id: @timecard
    end

    assert_redirected_to timecards_path
  end
end
