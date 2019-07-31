# require 'spec_helper'
require 'rails_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    it "content user name" do
      user = FactoryBot.build(:user)
      visit user_path(user)
      should hava_content(user.name)
    # it { should have_content(user.name) }
    # it { should have_title(user.name) }
    end
  end

=begin
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
=end
end
