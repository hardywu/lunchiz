class ApplicationController < ActionController::API
  include ApiError
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from AuthFailed, with: :auth_failed

  private

  def record_not_found(err)
    render json: { errors: [{ detail: err.message }] }, status: :not_found
  end

  # ActiveModel::Errors JSONAPI Serializer
  def ame_serialize(am_err)
    { errors: am_err.messages.map { |att, msg| { title: att, detail: msg } } }
  end

  def auth_failed
    render status: :unauthorized
  end

  def serialize(klass, resource, **options)
    "#{klass}Serializer".constantize.new(resource, options).serialized_json
  end
end
