require 'rails_helper'

RSpec.describe Micropost, type: :model do

  let(:user) { FactoryGirl.create(:user) }

  before do
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum", user_id: @user.id)
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }


 # describe "when " do

 # end


end
