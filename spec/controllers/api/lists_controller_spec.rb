require "spec_helper"

describe Api::ListsController do

  let!(:lists) do
    List.create!([
      { name: "List # 1" },
      { name: "List # 2" }
    ])
  end

  describe "#index" do
    before { get :index }

    it { expect(response.body).to eq(serialized(List.all)) }
  end

  describe "#show" do
    before { get :show, id: lists.last.id }

    it { expect(response.body).to eq(serialized(lists.last)) }
  end

  describe "#create" do
    before { post :create, list: { name: "A new List" } }

    it { expect(response.body).to eq(serialized(List.last)) }

    it { expect(List.count).to eq(3) }

    it { expect(List.last.name).to eq("A new List") }
  end

  def serialized(resource, options={})
    ActiveModel::Serializer.build_json(controller, resource, options).to_json
  end
end
