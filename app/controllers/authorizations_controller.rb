class AuthorizationsController < Devise::OmniauthCallbacksController
  def github
    @user = ::Users::OmniauthService.call(request.env["omniauth.auth"])

    flash[:notice] = 'Signed in successfully'
    sign_in_and_redirect @user, event: :authentication
  end
end
