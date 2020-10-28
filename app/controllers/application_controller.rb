class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def new
    @devise.new
    flash[:notice] = "Signed out successfully."
    redirect_to new_user_registration_path
  end

  def create
    @devise.save
    flash[:notice] = "Signed in successfully."
    redirect_to user_session_path
  end

end
