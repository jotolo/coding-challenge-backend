require "#{Rails.root}/lib/helpers.rb"
Mutations::Update::UpdateZombie = GraphQL::Relay::Mutation.define do
  name 'UpdateZombie'
  description 'Update a Zombie'

  return_type Types::ZombieType

  input_field :id, !types.ID
  input_field :name, types.String
  input_field :hit_points, types.Int
  input_field :brains_eaten, types.Int
  input_field :speed, types.Int
  input_field :turn_date, Types::DateType

  input_field :armors, types[Types::Input::ArmorInputType]
  input_field :weapons, types[Types::Input::WeaponInputType]

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    zombie = Zombie.find(item_id)
    zombie_params = args.to_h.deep_symbolize_keys.slice(:name, :hit_points, :brains_eaten,
                                                        :speed, :turn_date)
    zombie.assign_attributes(zombie_params)

    if (armors = args[:armors])
      armor_ids = zombie.armors.ids
      new_armors = args[:armors].to_a.map { |x| Helpers.decode_id(x[:id]) }

      add_armor_list = new_armors - armor_ids
      add_armor_list |= add_armor_list
      remove_list = armor_ids - new_armors
      remove_list |= remove_list

      # Removing Armors
      zombie.zombie_armors.find_all { |x| remove_list.include?(x.armor_id) }.each(&:mark_for_destruction)

      # Adding Armors
      armors.each do |armor|
        armor_id = Helpers.decode_id(armor[:id])
        if armor_id.nil?
          zombie.armors << Armor.new(armor.to_h)
        elsif add_armor_list.include?(armor_id)
          zombie.zombie_armors.build(armor_id: armor_id)
        else
          zombie.zombie_armors.first { |x| x.armor_id == armor_id }.assign_attributes(armor.to_h)
        end
      end
    end

    if (weapons = args[:weapons])
      weapon_ids = zombie.weapons.ids
      new_weapons = args[:weapons].to_a.map { |x| Helpers.decode_id(x[:id]) }

      add_weapon_list = new_weapons - weapon_ids
      add_weapon_list |= add_weapon_list
      remove_list = weapon_ids - new_weapons
      remove_list |= remove_list

      # Removing Weapons
      zombie.zombie_weapons.find_all { |x| remove_list.include?(x.weapon_id) }.each(&:mark_for_destruction)

      # Adding Weapons
      weapons.each do |weapon|
        weapon_id = Helpers.decode_id(weapon[:id])
        if weapon_id.nil?
          zombie.weapons << Armor.new(weapon.to_h)
        elsif add_weapon_list.include?(weapon_id)
          zombie.zombie_weapons.build(weapon_id: weapon_id)
        else
          zombie.zombie_weapons.first { |x| x.weapon_id == weapon_id }.assign_attributes(weapon.to_h)
        end
      end
    end

    zombie.update!(zombie_params)
    zombie
  }
end
