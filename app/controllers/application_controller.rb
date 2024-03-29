class ApplicationController < ActionController::API
  include ApiError
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotSaved, with: :unprocessable
  rescue_from AuthFailed, with: :auth_failed
  rescue_from InvalidParam, with: :unprocessable

  private

  def record_not_found(err)
    render json: { errors: [{ detail: err.message }] }, status: :not_found
  end

  # ActiveModel::Errors JSONAPI Serializer
  def ame_serialize(am_err)
    errors = am_err.messages.map do |att, msg|
      msg.map { |ms| { title: att, detail: "#{att} #{ms}" } }
    end
    { errors: errors.flatten }
  end

  def unprocessable(err)
    render json: { errors: [{ detail: err.message }] },
           status: :unprocessable_entity
  end

  def auth_failed
    render status: :unauthorized
  end

  def collection_meta(collection)
    {
      total: collection.count,
      page: collection.current_page,
      size: collection.size,
      limit: collection.limit_value
    }
  end

  def page
    params.fetch(:page, 1)
  end

  def per_page
    queries.fetch(:per_page, 20)
  end

  # add collection meta for collection
  def serialize(klass, resource, **options)
    options[:meta] = collection_meta(resource) if resource.respond_to? 'each'
    "#{klass}Serializer".constantize.new(resource, options).serialized_json
  end

  def queries
    params.transform_keys!(&:underscore)
  end

  def attributes
    params.fetch(:data, {}).fetch(:attributes, {}).transform_keys!(&:underscore)
  end

  def relationships
    params.fetch(:data, {}).fetch(:relationships, {}) \
          .transform_keys!(&:underscore)
  end

  def relationships_to_params!(relats)
    relats.map do |rel, data|
      if data['data'].is_a?(Array)
        [:"#{rel}_ids", data['data'].map { |d| d['id'] }]
      else
        [:"#{rel}_id", data['data']['id']]
      end
    end.to_h
  end

  def relationships_to_params(relats)
    relationships_to_params!(relats)
  rescue NoMethodError => err
    raise InvalidParam, 'Invalid JSON::API Body' + err.message
  end

  def current_user
    @current_user ||= User.of_jwt bearer_token
  end

  def bearer_token
    request.headers['Authorization']&.split(' ')&.[](1)
  end

  def authorize
    raise AuthFailed unless current_user
  end

  def authorize_user
    raise AuthFailed unless current_user&.type == 'User'
  end

  def authorize_owner
    raise AuthFailed unless current_user&.type == 'Owner'
  end

  def authorize_admin
    raise AuthFailed unless current_user&.type == 'Admin'
  end
end
