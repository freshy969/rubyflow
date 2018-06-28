module Posts
  class UserPolicy

    def self.editable?(post:, user:)
      return false if user.blank?

      post.user_id == user.id
    end

  end
end
