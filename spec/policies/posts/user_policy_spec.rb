require 'rails_helper'

describe Posts::UserPolicy do
  describe '.editable?' do
    it 'returns false if given user is blank' do
      post = instance_double(Post)

      expect(described_class.editable?(
        post: post, user: nil
      )).to eq(false)
    end

    it 'returns true if given user is present and is post owner' do
      post = instance_double(Post, user_id: 3)
      user = instance_double(User, id: 3)

      expect(described_class.editable?(
        post: post, user: user
      )).to eq(true)
    end

    it 'returns false if given user is present and is not post owner' do
      post = instance_double(Post, user_id: 2)
      user = instance_double(User, id: 3)

      expect(described_class.editable?(
        post: post, user: user
      )).to eq(false)
    end
  end
end
