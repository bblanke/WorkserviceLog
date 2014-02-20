class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?

   def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :t_hours, :week_hours, :isadmin, :activecard, :service_id, :email, :password, :password_confirmation) }
   end
   
   def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sing_in) { |u| u.permit(:name, :t_hours, :week_hours, :isadmin, :activecard, :service_id, :email, :password, :password_confirmation) }
   end
   
   def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :t_hours, :week_hours, :isadmin, :activecard, :service_id, :email, :password, :password_confirmation, :current_password) }
   end

   protect_from_forgery with: :exception
end
