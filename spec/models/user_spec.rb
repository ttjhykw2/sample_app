require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
        password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is too long" do
    before { @user.email = "a" * 244 + "@exmaple.com" }
    it { should_not be_valid }
  end

  describe "when email format is valid" do
    it "should be valid" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                    first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                  foo@bar_baz.com foo@bar+baz.cn foo@bar..com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "email addresses should be unique" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid}
  end

  describe "email addresses should be saved as lower-case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    before do
      @user.email = mixed_case_email
      @user.save
    end
    it { expect(@user.reload.email).to eq  mixed_case_email.downcase }
  end

  describe "when password is not present(blank)" do
    before { @user.password = @user.password_confirmation = " " * 6 }
    it { should_not be_valid }
  end

  describe "when password does not have a minimum length" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should_not be_valid }
  end

  describe "authenticated? should return false for a user with nil digest" do
    it { expect(@user.authenticated?(:remember, '')).to eq(false) }
  end

  describe "associated microposts should be destroyed" do
    before do
      @user.save
      @user.microposts.create!(content: "Lorem ipsum")
    end
    it { expect {@user.destroy}.to change(Micropost, :count).by(-1) }
  end
end

RSpec.describe "follow and micropost", type: :request do
  it "follow and unfollow a user" do
    @michael = FactoryBot.create(:michael)
    @archer = FactoryBot.create(:archer)

    expect(@michael.following?(@archer)).to be_falsey
    @michael.follow(@archer)
    expect(@michael.following?(@archer)).to be_truthy
    expect(@archer.followers.include?(@michael)).to be_truthy
    @michael.unfollow(@archer)
    expect(@michael.following?(@archer)).to be_falsey
  end

  it "feed should have the right posts" do
    @michael = FactoryBot.create(:michael)
    @archer = FactoryBot.create(:archer)
    @lana = FactoryBot.create(:lana)

    # フォローしているユーザの投稿を確認
    @lana.microposts.each do |post_following|
      expect(@michael.feed.include?(post_following)).to be_truthy
    end
    # 自分自身の投稿を確認
    @michael.microposts.each do |post_self|
      expect(@michael.feed.include?(post_self)).to be_truthy
    end
    # フォローしていないユーザの投稿を確認
    @archer.microposts.each do |post_unfollowed|
      expect(@michael.feed.include?(post_unfollowed)).to be_falsey
    end
  end

  # it 'should be valid' do # 期待する動作説明を書く
  #   user = User.new(name: '')
  #   expect(user).not_to be_valid # 動作をテストする部分
  # end
end
