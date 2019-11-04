require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @relationship = Relationship.new(follower_id: FactoryBot.create(:michael).id,
                                     followed_id: FactoryBot.create(:archer).id)
  end

  describe "should be valid" do
    it { expect(@relationship.valid?).to be_truthy}
  end

  describe "should require a follower_id" do
    it { @relationship.follower_id = nil
      expect(@relationship.valid?).to be_falsey }
  end

  describe "should require a followed_id" do
    it { @relationship.followed_id = nil
      expect(@relationship.valid?).to be_falsey }
  end
end
