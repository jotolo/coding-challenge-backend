module Functions
  class FindRecord < GraphQL::Function
    # Define `initialize` to store field-level options, eg
    #
    #     field :myField, function: Functions::FindRecord.new(model: MyModel, type: MyType)
    #
    attr_reader :type
    attr_reader :model
    def initialize(model:, type:)
      @model = model
      @type = type
    end

    # add arguments by type:
    argument :id, !types.ID

    # Resolve function:
    def call(_obj, args, _ctx)
      _, item_id = GraphQL::Schema::UniqueWithinType.decode(args[:id])
      @model.find(item_id.to_i)
    end
  end
end
