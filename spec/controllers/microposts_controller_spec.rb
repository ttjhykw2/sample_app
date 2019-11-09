require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  before do
    @micropost = FactoryBot.create(:orange)
  end

  it "should redirect create when not logged in" do
    expect { post :create, params: {micropost: { content: "Lorem ipsum"} }
      }.not_to change(Micropost, :count)
    expect(response).to redirect_to login_url
  end

  it "should redirect destroy when not logged in" do
    expect { delete :destroy, params: {id: @micropost }
    }.not_to change(Micropost, :count)
    expect(response).to redirect_to login_url
  end

  it "should redirect destroy for wrong micropost" do
    micropost = FactoryBot.create(:ants)
    log_in_as(FactoryBot.build(:michael))
    expect { delete :destroy, params: {id: micropost }
    }.not_to change(Micropost, :count)
    expect(response).to redirect_to login_url
  end
end
