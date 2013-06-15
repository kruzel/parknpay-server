require 'test_helper'

class CreditorsControllerTest < ActionController::TestCase
  setup do
    @creditor = creditors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:creditors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create creditor" do
    assert_difference('Creditor.count') do
      post :create, creditor: { bank_account: @creditor.bank_account, bank_code: @creditor.bank_code, bank_name: @creditor.bank_name, bank_office: @creditor.bank_office, contact_email: @creditor.contact_email, contact_name: @creditor.contact_name, contact_phone: @creditor.contact_phone, name: @creditor.name }
    end

    assert_redirected_to creditor_path(assigns(:creditor))
  end

  test "should show creditor" do
    get :show, id: @creditor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @creditor
    assert_response :success
  end

  test "should update creditor" do
    put :update, id: @creditor, creditor: { bank_account: @creditor.bank_account, bank_code: @creditor.bank_code, bank_name: @creditor.bank_name, bank_office: @creditor.bank_office, contact_email: @creditor.contact_email, contact_name: @creditor.contact_name, contact_phone: @creditor.contact_phone, name: @creditor.name }
    assert_redirected_to creditor_path(assigns(:creditor))
  end

  test "should destroy creditor" do
    assert_difference('Creditor.count', -1) do
      delete :destroy, id: @creditor
    end

    assert_redirected_to creditors_path
  end
end
