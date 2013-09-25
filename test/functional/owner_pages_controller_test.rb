require 'test_helper'

class OwnerPagesControllerTest < ActionController::TestCase
  setup do
    @owner_dashboard = owner_dashboards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:owner_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create owner_dashboard" do
    assert_difference('OwnerDashboard.count') do
      post :create, owner_dashboard: {  }
    end

    assert_redirected_to owner_dashboard_path(assigns(:owner_dashboard))
  end

  test "should show owner_dashboard" do
    get :show, id: @owner_dashboard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @owner_dashboard
    assert_response :success
  end

  test "should update owner_dashboard" do
    put :update, id: @owner_dashboard, owner_dashboard: {  }
    assert_redirected_to owner_dashboard_path(assigns(:owner_dashboard))
  end

  test "should destroy owner_dashboard" do
    assert_difference('OwnerDashboard.count', -1) do
      delete :destroy, id: @owner_dashboard
    end

    assert_redirected_to owner_dashboards_path
  end
end
