BadiCodingChallengeBackendSchema = GraphQL::Schema.define do
  # Relay Object Identification:

  # Return a string UUID for `object`
  id_from_object lambda { |object, type_definition, _query_ctx|
    # Here's a simple implementation which:
    # - joins the type name & object.id
    # - encodes it with base64:
    GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
  }

  # Given a string UUID, find the object
  object_from_id lambda { |id, _query_ctx|
    # For example, to decode the UUIDs generated above:
    # type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    #
    # Then, based on `type_name` and `id`
    # find an object in your application
    # ...
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    type_name.constantize.find(item_id.to_i)
  }

  # Object Resolution
  resolve_type lambda { |type, obj, _ctx|
    # to return the correct type for `obj`
    case type
    when Zombie
      Types::ZombieType
    when Armor
      Types::ArmorType
    when Weapon
      Types::WeaponType
    when ZombieArmor
      Types::ZombieArmorType
    when ZombieWeapon
      Types::ZombieWeaponType
    else
      raise("Unexpected object: #{obj}")
    end
  }

  mutation(Types::MutationType)
  query(Types::QueryType)

  # GraphQL::Batch setup:
  use GraphQL::Batch
  enable_preloading
end

GraphQL::Errors.configure(BadiCodingChallengeBackendSchema) do
  rescue_from ActiveRecord::RecordNotFound do |exception|
    GraphQL::ExecutionError.new(exception.message, options: { status: 404 })
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    if exception.record
      keys = exception.record.errors.keys
      GraphQL::ExecutionError.new(exception.record.errors.full_messages.join(' | '), options: { status: 422, keys: keys })
    else
      GraphQL::ExecutionError.new(exception.message, options: { status: 422 })
    end
  end

  rescue_from ActiveRecord::RecordNotDestroyed do |exception|
    if exception.record
      keys = exception.record.errors.keys
      GraphQL::ExecutionError.new(exception.record.errors.full_messages.join(' | '), options: { status: 422, keys: keys })
    else
      GraphQL::ExecutionError.new(exception.message, options: { status: 422 })
    end
  end

  rescue_from ActiveRecord::RecordNotSaved do |exception|
    if exception.record
      keys = exception.record.errors.keys
      GraphQL::ExecutionError.new(exception.record.errors.full_messages.join(' | '), options: { status: 422, keys: keys })
    else
      GraphQL::ExecutionError.new(exception.message, options: { status: 422 })
    end
  end

  rescue_from StandardError do |exception|
    GraphQL::ExecutionError.new(exception.message)
  end
end
