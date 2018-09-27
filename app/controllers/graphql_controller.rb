class GraphqlController < ApplicationController
  def execute
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
    }

    # You can change your schema easily if you want to try any other thing
    schema = BadiCodingChallengeBackendSchema
    result = if params[:_json].present? # multiplexing request
               execute_queries(params, context, schema)
             elsif params[:query].present? # single query request
               execute_query(params, context, schema)
             end

    render json: result
  end

  private

  def execute_queries(params, context, schema)
    queries = params.to_h[:_json].map do |query|
      {
        query: query['query'],
        variables: ensure_hash(query['variables']),
        operation_name: query['operation_name'],
        context: context
      }
    end

    schema.multiplex(queries, context: context)
  end

  def execute_query(params, context, schema)
    query = params[:query]
    variables = ensure_hash(params[:variables])
    operation_name = params[:operation_name]

    schema.execute(query, variables: variables, context: context, operation_name: operation_name)
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
