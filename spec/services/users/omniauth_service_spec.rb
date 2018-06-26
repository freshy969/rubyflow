require 'rails_helper'

describe Users::OmniauthService do
  describe '.call' do
    it 'returns existing user if user is found by the given provider and UID' do
      provider = 'github'
      uid = 'abcd123'
      auth = double(provider: provider, uid: uid)
      user = create(:user, provider: provider, uid: uid, name: "John Doe", profile_url: 'url', image_url: 'url')

      result = described_class.call(auth)

      expect(result).to eq(user)
    end

    it 'creates new user if user is not found by the given provider and UID' do
      provider = 'github'
      uid = 'abcd123'
      auth_info = double(name: 'John Doe', image: 'url', urls: {'GitHub' => 'https://github.com/rubyhero'})
      auth = double(provider: provider, uid: uid, info: auth_info)

      result = described_class.call(auth)

      expect(result).to be_instance_of(User)
      expect(result.provider).to eq(provider)
      expect(result.uid).to eq(uid)
      expect(result.name).to eq('John Doe')
      expect(result.profile_url).to eq('https://github.com/rubyhero')
      expect(result.image_url).to eq('url')
    end
  end
end
