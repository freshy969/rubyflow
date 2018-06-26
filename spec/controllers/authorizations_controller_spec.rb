require 'rails_helper'

describe AuthorizationsController do
  describe 'POST #github' do
    it 'authorizes user' do
      auth = double('auth')
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env["omniauth.auth"] = auth
      user = instance_double(User)
      allow(Users::OmniauthService).to receive(:call).with(
        auth
      ).and_return(user)
      allow(controller).to receive(:sign_in_and_redirect).with(user, event: :authentication)

      post :github

      expect(Users::OmniauthService).to have_received(:call).with(
        auth
      ).once
      expect(controller).to have_received(:sign_in_and_redirect).with(
        user, event: :authentication
      ).once
    end
  end
end
