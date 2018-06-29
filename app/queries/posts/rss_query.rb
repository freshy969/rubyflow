module Posts
  class RSSQuery

    def self.call
      ::Post.order(created_at: :desc).limit(10)
    end

  end
end
