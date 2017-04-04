class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  helper_method :current_user
  before_filter :authenticate_user!, unless: :pages_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "No estás autorizado a realizar esa acción"
    redirect_to(request.referrer || profile_path)
  end

  def authenticate_user!
    unless current_user
      redirect_to root_path
    end
  end

  def pages_controller?
    controller_path.starts_with?("pages") || controller_path.starts_with?("sessions")
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
