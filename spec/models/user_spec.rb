require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
        password: "foobar", password_confirmation: "foobar")
  end

  it "should be valid" do
    assert @user.valid?
  end

=begin
  it 'should be valid' do # 期待する動作説明を書く
    user = User.new(name: '')
    expect(user).not_to be_valid # 動作をテストする部分
  end
=end

end
