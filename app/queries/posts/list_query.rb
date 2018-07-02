module Posts
  class ListQuery

    def self.call(offset: nil)
      if offset.present?
        ::Post.joins(:user).includes(comments: :user).order(created_at: :desc)
          .offset(offset.to_i).limit(5)
      else
        ::Post.joins(:user).includes(comments: :user).order(created_at: :desc)
      end
    end

  end
end
