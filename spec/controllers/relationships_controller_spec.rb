require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  it "create should require logged-in user" do
    expect { post :create }.not_to change(Relationship, :count)
    expect(response).to redirect_to login_url
  end

  it "destroy should require logged-in user" do
    one = FactoryBot.create(:one)
    expect { delete :destroy, params: {id: one}}.not_to change(Relationship, :count)
    expect(response).to redirect_to login_url
  end
end
