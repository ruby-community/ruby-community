class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :github

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:success, :success, :kind => "GitHub") if is_navigational_format?
    else
      redirect_to root_path, alert: "You are not allowed to access this application."
    end
  end
end
