module Users
  class OmniauthService

    def self.call(auth)
      ::User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.name = "John Doe"
        user.profile_url = "https://github.com/rubyhero"
        user.image_url = "url"
      end
    end

  end
end
