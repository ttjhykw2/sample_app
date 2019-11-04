require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:michael) }
  let(:other_user) { FactoryBot.create(:archer) }

  it "should redirect index when not logged in" do
    get :index
    expect(response).to redirect_to login_url
  end

  it "should get new" do
    get :new
    #get signup_path
    expect(response).to have_http_status :success
  end
=begin
  it "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  it "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  it "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  it "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email }}
    assert flash.empty?
    assert_redirected_to root_url
  end

  it "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
      user: { password: 'password',
              password_confirmation: 'password',
              admin: true }}
    assert_not @other_user.reload.admin?
  end

  it "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  it "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  it "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  it "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
=end
end
