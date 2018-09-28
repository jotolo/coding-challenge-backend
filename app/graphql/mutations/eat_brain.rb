require "#{Rails.root}/lib/helpers.rb"
Mutations::EatBrain = GraphQL::Relay::Mutation.define do
  name 'EatBrain'
  description 'Allow Zombies to eat brains'

  return_type Types::ZombieType

  input_field :id, !types.ID

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    zombie = Zombie.find(item_id)

    zombie.increment!(:brains_eaten)
    zombie
  }
end
