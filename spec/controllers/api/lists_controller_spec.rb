require "spec_helper"

describe Api::ListsController do
  before do
    List.create!([
      { name: "List # 1" },
      { name: "List # 2" }
    ])
  end

  describe "#index" do
    before { get :index }

    it { expect(response.body).to eq(List.all.to_json) }
  end

  describe "#show" do
    before { get :show, id: List.first.id }

    it { expect(response.body).to eq(List.first.to_json) }
  end
end