module Functions
  class FindZombies < GraphQL::Function
    # Define `initialize` to store field-level options, eg
    #
    #     field :myField, function: Functions::FindAllRecords.new(type: MyType)
    #
    attr_reader :model
    attr_reader :type
    def initialize
      @model = Zombie
      @type = Types::ZombieType.to_list_type
    end

    # add arguments by type:
    argument :filter, Types::Filter::ZombieFilterType
    argument :limit, types.Int
    argument :offset, types.Int

    # Resolve function:
    def call(obj, args, _ctx)
      scope = obj&.zombies || @model.all

      if (filter = args[:filter])
        unless filter[:id].blank?
          ids = Helpers.decode_ids(filter[:id])
          scope = scope.where(id: ids)
        end
        scope = scope.where(zombies_like('name', filter[:name])) unless filter[:name].blank?

        # Int Ranges
        unless filter[:hit_points].blank?
          range = filter[:hit_points]
          scope = weapons_range_filter(:hit_points, scope, range)
        end

        unless filter[:brains_eaten].blank?
          range = filter[:brains_eaten]
          scope = weapons_range_filter(:brains_eaten, scope, range)
        end

        unless filter[:speed].blank?
          range = filter[:speed]
          scope = weapons_range_filter(:speed, scope, range)
        end

        unless filter[:turn_date].blank?
          range = filter[:turn_date]
          if range[:from] && range[:to]
            scope = scope.where('zombies.turn_date >= :from AND zombies.turn_date <= :to', from: range[:from], to: range[:to])
          elsif !range[:from] && range[:to]
            scope = scope.where('zombies.turn_date <= :to', to: range[:to])
          elsif range[:from] && !range[:to]
            scope = scope.where('zombies.turn_date >= :from', from: range[:from])
          end
        end
      end

      scope = scope.limit(args[:limit]) if args[:limit]

      scope = scope.offset(args[:offset]) if args[:offset]

      scope
    end

    private

    def zombies_like(field_name, values)
      values.collect { |value| "zombies.#{field_name} ILIKE '%#{value}%'" }.join(' OR ')
    end

    def weapons_range_filter(field_name, scope, range)
      if range[:min] && range[:max]
        scope = scope.where("zombies.#{field_name} >= :min AND zombies.#{field_name} <= :max", min: range[:min], max: range[:max])
      elsif !range[:min] && range[:max]
        scope = scope.where("zombies.#{field_name} <= :max", max: range[:max])
      elsif range[:min] && !range[:max]
        scope = scope.where("zombies.#{field_name} >= :min", min: range[:min])
      end
      scope
    end
  end
end
