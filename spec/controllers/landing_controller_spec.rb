require 'spec_helper'

describe LandingController do

  describe :routing do
    it { expect(get: "/").to route_to("landing#index") }
  end

  describe "#index" do
    before { get :index }

    it { expect(response).to render_template("index") }
    it { expect(response.status).to eq(200) }
  end
end
