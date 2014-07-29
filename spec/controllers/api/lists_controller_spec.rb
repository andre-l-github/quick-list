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
    context "list exists" do
      before { get :show, id: lists.last.id }

      it { expect(response.body).to eq(serialized(lists.last)) }
    end

    context "list does not exist" do
      before { delete :destroy, id: lists.first.id.to_s.next }

      it { expect(response.status).to eq(404) }
    end
  end

  describe "#create" do
    before { post :create, list: { name: "A new List" } }

    it { expect(response.body).to eq(serialized(List.last)) }

    it { expect(List.count).to eq(3) }

    it { expect(List.last.name).to eq("A new List") }
  end

  describe "#destroy" do
    context "list exists" do
      before { delete :destroy, id: lists.first.id }

      it { expect(List.count).to eq(1) }
    end

    context "list does not exist" do
      before { delete :destroy, id: lists.first.id.to_s.next }

      it { expect(List.count).to eq(2) }

      it { expect(response.status).to eq(404) }
    end
  end

  def serialized(resource, options={})
    ActiveModel::Serializer.build_json(controller, resource, options).to_json
  end
end
