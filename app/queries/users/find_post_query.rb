module Users
  class FindPostQuery

    def self.call(user:, post_id:)
      user.posts.find_by!(slug: post_id)
    end

  end
end
