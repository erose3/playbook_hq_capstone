class ApplicationController < ActionController::Base
  skip_forgery_protection

  before_action :configure_permitted_parameters, if: :devise_controller?

   protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(
       :sign_up,
       keys: [
         :username,
         :first_name,
         :last_name,
         :account_type,
         :organization,
       ]
     )
     devise_parameter_sanitizer.permit(
       :account_update,
       keys: [
         :username,
         :first_name,
         :last_name,
         :account_type,
         :organization,
       ]
     )
   end

  #  def after_sign_in_path_for(resource)
  #    if session.fetch("invite_token", nil)
  #      token = session.fetch("invite_token")
  #      session.store("invite_token", nil)
  #      "/join/#{token}"
  #    else
  #      super
  #    end
  #  end
 end
