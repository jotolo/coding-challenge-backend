require "#{Rails.root}/lib/helpers.rb"
Mutations::Create::CreateZombie = GraphQL::Relay::Mutation.define do
  name 'CreateZombie'
  description 'Create a Zombie'

  return_type Types::ZombieType

  input_field :name, !types.String
  input_field :hit_points, !types.Int
  input_field :brains_eaten, !types.Int
  input_field :speed, !types.Int
  input_field :turn_date, !Types::DateType

  input_field :armors, types[Types::Input::ArmorInputType]
  input_field :weapons, types[Types::Input::WeaponInputType]

  resolve lambda { |_obj, args, _ctx|
    zombie_params = args.to_h.deep_symbolize_keys.slice(:name, :hit_points, :brains_eaten,
                                                        :speed, :turn_date)

    zombie = Zombie.new(zombie_params)

    if (armors = args[:armors])
      armors.each do |armor|
        zombie.armors << Armor.new(armor.to_h)
      end
    end

    if (weapons = args[:weapons])
      weapons.each do |weapon|
        zombie.weapons << Weapon.new(weapon.to_h)
      end
    end

    zombie.save!
  }
end
