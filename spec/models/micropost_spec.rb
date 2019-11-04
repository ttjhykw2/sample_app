require 'rails_helper'

RSpec.describe Micropost, type: :model do

  before do
    @user = FactoryBot.create(:michael_with_microposts)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  it { expect(@micropost).to be_valid }

  describe "user id should be present" do
    it {@micropost.user_id = nil
      expect(@micropost).not_to be_valid }
  end

  describe "content should be present" do
    it { @micropost.content = " "
      expect(@micropost).not_to be_valid }
  end

  describe "content should be at most 140 characters" do
    it { @micropost.content = "a" * 141
      expect(@micropost).not_to be_valid }
  end

  describe "order should be most recent first" do
    it { content = FactoryBot.attributes_for(:most_recent)[:content]
      most_recent = Micropost.find_by! content: content
      expect(Micropost.first).to eq most_recent }
  end
end
