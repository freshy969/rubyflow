class User < ApplicationRecord
  devise :database_authenticatable, :validatable, 
         :omniauthable, omniauth_providers: %i[github]
end
