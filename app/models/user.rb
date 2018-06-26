class User < ApplicationRecord
  devise :database_authenticatable, :omniauthable, omniauth_providers: %i[github]
end
