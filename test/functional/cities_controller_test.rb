require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  setup do
    @city = cities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create city_id" do
    assert_difference('City.count') do
      post :create, city_id: { name: @city.name }
    end

    assert_redirected_to city_path(assigns(:city_id))
  end

  test "should show city_id" do
    get :show, id: @city
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @city
    assert_response :success
  end

  test "should update city_id" do
    put :update, id: @city, city_id: { name: @city.name }
    assert_redirected_to city_path(assigns(:city_id))
  end

  test "should destroy city_id" do
    assert_difference('City.count', -1) do
      delete :destroy, id: @city
    end

    assert_redirected_to cities_path
  end
end
