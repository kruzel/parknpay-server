require 'test_helper'

class BankAccountsControllerTest < ActionController::TestCase
  setup do
    @bankaccount = creditors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bankaccount" do
    assert_difference('BankAccount.count') do
      post :create, bankaccount: { bank_account: @bankaccount.bank_account, bank_code: @bankaccount.bank_code, bank_name: @bankaccount.bank_name, bank_office: @bankaccount.bank_office, contact_email: @bankaccount.contact_email, contact_name: @bankaccount.contact_name, contact_phone: @bankaccount.contact_phone, name: @bankaccount.name }
    end

    assert_redirected_to bank_account_path(assigns(:bankaccount))
  end

  test "should show bankaccount" do
    get :show, id: @bankaccount
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bankaccount
    assert_response :success
  end

  test "should update bankaccount" do
    put :update, id: @bankaccount, bankaccount: { bank_account: @bankaccount.bank_account, bank_code: @bankaccount.bank_code, bank_name: @bankaccount.bank_name, bank_office: @bankaccount.bank_office, contact_email: @bankaccount.contact_email, contact_name: @bankaccount.contact_name, contact_phone: @bankaccount.contact_phone, name: @bankaccount.name }
    assert_redirected_to bank_account_path(assigns(:bankaccount))
  end

  test "should destroy bankaccount" do
    assert_difference('BankAccount.count', -1) do
      delete :destroy, id: @bankaccount
    end

    assert_redirected_to bank_accounts_path
  end
end
