class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :open, :closed

  def id
    "#{object.id.to_s}"
  end

  def open
    0
  end

  def closed
    0
  end
end
