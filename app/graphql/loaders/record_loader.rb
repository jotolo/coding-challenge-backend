require 'graphql/batch'
module Loaders
  class RecordLoader < GraphQL::Batch::Loader
    def initialize(model)
      @model = model
    end

    # `keys` contains each key from `.load(key)`.
    # Find the corresponding values, then
    # call `fulfill(key, value)` or `fulfill(key, nil)`
    # for each key.
    def perform(ids)
      @model.where(id: ids).each { |record| fulfill(record.id, record) }
      ids.each { |id| fulfill(id, nil) unless fulfilled?(id) }
    end
  end
end
