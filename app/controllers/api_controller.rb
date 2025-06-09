class ApiController < ActionController::API
  before_action :set_locale
  @@per = 10
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
  rescue_from ActionController::BadRequest, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotUnique, with: :conflict

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def not_found(exception)
    render_error(:not_found, exception)
  end

  def unprocessable_entity(exception)
    render_error(:unprocessable_entity, exception)
  end

  def conflict(exception)
    render_error(:conflict, exception)
  end

  def render_error(key, exception)
    render json: {
      error: I18n.t("errors.#{key}.title"),
      message: I18n.t("errors.#{key}.message"),
      details: exception.message
    }, status: key
  end
end
