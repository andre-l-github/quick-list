class List
  include Mongoid::Document
  include ObservableModel

  field :name, type: String
end
