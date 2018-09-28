module Helpers
  def self.decode_id(id)
    return nil if id.nil?

    _, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    item_id.to_i
  end

  def self.decode_ids(ids)
    return nil if ids.nil?

    ids.map { |x| decode_id(x) }
  end

  def self.decode_type(id)
    type_name, = GraphQL::Schema::UniqueWithinType.decode(id)
    type_name
  end

  def self.decode_types(ids)
    ids.map { |x| decode_type(x) }
  end

  def self.decode_ids_and_types(ids)
    ids.map { |x| [decode_id(x), decode_type(x)] }
  end
end
