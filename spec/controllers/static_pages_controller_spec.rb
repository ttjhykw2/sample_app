require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  before do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  it "should get root" do
    get :home
    expect(response).to have_http_status :success
  end
=begin
  it "should get home" do
    get :home
    expect(response).to have_http_status :success
    #assert_select "title", @base_title
  end

  it "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  it "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  it "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
=end
end
