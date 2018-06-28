class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[github]

  has_many :posts
end
