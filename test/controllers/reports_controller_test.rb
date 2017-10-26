require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get sale_report" do
    get :sale_report
    assert_response :success
  end

end
