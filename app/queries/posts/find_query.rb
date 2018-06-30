module Posts
  class FindQuery

    def self.call(slug)
      ::Post.includes(comments: :user).find_by!(slug: slug)
    end

  end
end
