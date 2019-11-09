require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do

  before do
    ActionMailer::Base.deliveries.clear
  end

  it "invalid signup information" do
    get signup_path
    expect {
      post users_path, params: { user: { name:"",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar"}}
    }.to_not change(User, :count)

    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'form[action="/signup"]'
  end

  it "valid signup information with account activation" do
    get signup_path
    expect {
      post users_path, params: { user: { name:"Example User",
                                         email: "user@example.com",
                                         password: "password",
                                         password_confirmation: "password"}}
    }.to change(User, :count).by(1)

    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    expect(user.activated?).to be_falsey
    # assert_not user.activated?
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    expect(is_logged_in?).to be_falsey
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    expect(is_logged_in?).to be_falsey
    #assert_not is_logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    expect(is_logged_in?).to be_falsey
    #assert_not is_logged_in?
    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    #assert_not flash.empty?
    expect(is_logged_in?).to be_truthy
    #assert is_logged_in?
  end
end
