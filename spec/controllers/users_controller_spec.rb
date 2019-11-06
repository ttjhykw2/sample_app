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

  it "should redirect edit when not logged in" do
    get :edit, params: {id: user}
    expect(flash).to be_present
    expect(response).to redirect_to login_url
  end

  it "should redirect update when not logged in" do
    patch :update, params: { id: user, user: { name: user.name, email: user.email } }
    expect(flash).to be_present
    expect(response).to redirect_to login_url
  end

  it "should redirect edit when logged in as wrong user" do
    log_in_as(other_user)
    get :edit, params: {id: user}
    expect(flash).to be_empty
    expect(response).to redirect_to root_url
  end

  it "should redirect update when logged in as wrong user" do
    log_in_as(other_user)
    patch :update, params: { id: user, user: { name: user.name,
                                              email: user.email }}
    expect(flash).to be_empty
    expect(response).to redirect_to root_url
  end

  it "should not allow the admin attribute to be edited via the web" do
    log_in_as(other_user)
    expect(other_user.admin?). to be_falsey
    patch :update, params: { id: other_user,
              user: { password: 'password',
              password_confirmation: 'password',
              admin: true }}
    expect(other_user.reload.admin?).to be_falsey
  end

  it "should redirect destroy when not logged in" do
    #assert_no_difference 'User.count' do
    #  delete user_path(@user)
    #end
    expect { delete :destroy, params: {id: user}}.to_not change(User, :count)
    expect(response).to redirect_to login_url
  end

  it "should redirect destroy when logged in as a non-admin" do
    log_in_as(other_user)
    expect { delete :destroy, params: {id: user}}.to_not change(User, :count)
    expect(response).to redirect_to root_url
  end

  it "should redirect following when not logged in" do
    get :following, params: {id: user}
    expect(response).to redirect_to login_url
  end

  it "should redirect followers when not logged in" do
    get :followers, params: {id: user}
    expect(response).to redirect_to login_url
  end
end
