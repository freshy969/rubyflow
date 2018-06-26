module Users
  class OmniauthService

    def self.call(auth)
      ::User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.name = auth.info.name
        user.profile_url = auth.info.urls["GitHub"]
        user.image_url = auth.info.image
      end
    end

  end
end
