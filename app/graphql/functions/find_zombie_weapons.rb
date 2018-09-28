module Functions
  class FindZombieWeapons < GraphQL::Function
    attr_reader :model
    attr_reader :type
    def initialize
      @model = ZombieWeapon
      @type = Types::ZombieWeaponType.to_list_type
    end

    # add arguments by type:
    argument :filter, Types::Filter::ZombieWeaponFilterType
    argument :limit, types.Int
    argument :offset, types.Int

    # Resolve function:
    def call(obj, args, _ctx)
      scope = obj&.zombie_weapons || @model.all

      if (filter = args[:filter])
        unless filter[:id].blank?
          ids = Helpers.decode_ids(filter[:id])
          scope = scope.where(id: ids)
        end

        unless filter[:zombie_ids].blank?
          ids = Helpers.decode_ids(filter[:zombie_ids])
          scope = scope.where(zombie_id: ids)
        end

        unless filter[:weapon_ids].blank?
          ids = Helpers.decode_ids(filter[:weapon_ids])
          scope = scope.where(weapon_id: ids)
        end
      end

      scope = scope.limit(args[:limit]) if args[:limit]

      scope = scope.offset(args[:offset]) if args[:offset]

      scope
    end
  end
end
