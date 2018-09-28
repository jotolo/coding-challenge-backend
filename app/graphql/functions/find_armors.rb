module Functions
  class FindArmors < GraphQL::Function
    # Define `initialize` to store field-level options, eg
    #
    #     field :myField, function: Functions::FindArmors.new
    #
    attr_reader :model
    attr_reader :type
    def initialize
      @model = Armor
      @type = Types::ArmorType.to_list_type
    end

    # add arguments by type:
    argument :filter, Types::Filter::ArmorFilterType
    argument :limit, types.Int
    argument :offset, types.Int

    # Resolve function:
    def call(obj, args, _ctx)
      scope = obj&.armors || @model.all

      if (filter = args[:filter])
        unless filter[:id].blank?
          ids = Helpers.decode_ids(filter[:id])
          scope = scope.where(id: ids)
        end
        scope = scope.where(armors_like('name', filter[:name])) unless filter[:name].blank?

        # Int Ranges
        unless filter[:defense_points].blank?
          range = filter[:defense_points]
          scope = weapons_range_filter(:defense_points, scope, range)
        end

        unless filter[:durability].blank?
          range = filter[:durability]
          scope = weapons_range_filter(:durability, scope, range)
        end

        unless filter[:price].blank?
          range = filter[:price]
          scope = weapons_range_filter(:price, scope, range)
        end
      end

      scope = scope.order(args[:sort]) if args[:sort]

      scope = scope.limit(args[:limit]) if args[:limit]

      scope = scope.offset(args[:offset]) if args[:offset]

      scope
    end

    private

    def armors_like(field_name, values)
      values.collect { |value| "armors.#{field_name} ILIKE '%#{value}%'" }.join(' OR ')
    end

    def armors_range_filter(field_name, scope, range)
      if range[:min] && range[:max]
        scope = scope.where("armors.#{field_name} >= :min AND armors.#{field_name} <= :max", min: range[:min], max: range[:max])
      elsif !range[:min] && range[:max]
        scope = scope.where("armors.#{field_name} <= :max", max: range[:max])
      elsif range[:min] && !range[:max]
        scope = scope.where("armors.#{field_name} >= :min", min: range[:min])
      end
      scope
    end
  end
end
