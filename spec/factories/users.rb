FactoryBot.define do
  factory :user do
    provider 'provider'
    uid 'uid'
    name 'John Doe'
    image_url 'url'
    profile_url 'url'
  end
end
