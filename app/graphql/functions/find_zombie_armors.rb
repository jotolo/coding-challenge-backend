module Functions
  class FindZombieArmors < GraphQL::Function
    # Define `initialize` to store field-level options, eg
    #
    #     field :myField, function: Functions::FindAllRecords.new(type: MyType)
    #
    attr_reader :model
    attr_reader :type
    def initialize
      @model = ZombieArmor
      @type = Types::ZombieArmorType.to_list_type
    end

    # add arguments by type:
    argument :filter, Types::Filter::ZombieArmorFilterType
    argument :limit, types.Int
    argument :offset, types.Int

    # Resolve function:
    def call(obj, args, _ctx)
      scope = obj&.zombie_armors || @model.all

      if (filter = args[:filter])
        unless filter[:id].blank?
          ids = Helpers.decode_ids(filter[:id])
          scope = scope.where(id: ids)
        end

        unless filter[:zombie_ids].blank?
          ids = Helpers.decode_ids(filter[:zombie_ids])
          scope = scope.where(zombie_id: ids)
        end

        unless filter[:armor_ids].blank?
          ids = Helpers.decode_ids(filter[:armor_ids])
          scope = scope.where(armor_id: ids)
        end
      end

      scope = scope.limit(args[:limit]) if args[:limit]

      scope = scope.offset(args[:offset]) if args[:offset]

      scope
    end

    private

    def zombie_armors_like(field_name, values)
      values.collect { |value| "zombie_armors.#{field_name} ILIKE '%#{value}%'" }.join(' OR ')
    end
  end
end
