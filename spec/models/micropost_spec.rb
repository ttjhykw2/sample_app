require 'rails_helper'

RSpec.describe Micropost, type: :model do

  before do
    @user = FactoryBot.create(:michael_with_microposts)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  it { expect(@micropost).to be_valid }

  describe "user id should be present" do
    before { @micropost.user_id = nil }
    it { expect(@micropost).not_to be_valid }
  end

  describe "content should be present" do
    before { @micropost.content = " " }
    it { expect(@micropost).not_to be_valid }
  end

  describe "content should be at most 140 characters" do
    before { @micropost.content = "a" * 141 }
    it { expect(@micropost).not_to be_valid }
  end

  specify "order should be most recent first" do
    content = FactoryBot.attributes_for(:most_recent)[:content]
    most_recent = Micropost.find_by! content: content
    expect(Micropost.first).to eq most_recent
  end
end
