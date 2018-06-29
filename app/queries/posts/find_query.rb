module Posts
  class FindQuery

    def self.call(id)
      ::Post.includes(comments: :user).find(id)
    end

  end
end
