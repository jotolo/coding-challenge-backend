module Functions
  class FindAllRecords < GraphQL::Function
    # Define `initialize` to store field-level options, eg
    #
    #     field :myField, function: Functions::FindAllRecords.new(model: MyModel, type: MyType)
    #
    attr_reader :model
    attr_reader :type
    def initialize(model:, type:)
      @model = model
      @type = type
    end

    # add arguments by type:
    argument :limit, types.Int
    argument :offset, types.Int

    # Resolve function:
    def call(_obj, args, _ctx)
      scope = @model.all

      scope = scope.limit(args[:limit]) if args[:limit]

      scope = scope.offset(args[:offset]) if args[:offset]

      scope
    end
  end
end
