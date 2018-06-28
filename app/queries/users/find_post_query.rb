module Users
  class FindPostQuery

    def self.call(user:, post_id:)
      user.posts.find(post_id)
    end

  end
end
