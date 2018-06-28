module Posts
  class ListQuery

    def self.call
      ::Post.joins(:user).order(created_at: :desc)
    end

  end
end
