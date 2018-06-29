require 'rails_helper'

describe CommentsController do
  describe 'POST #create' do
    it 'redirects to the root page if user is not signed in' do
      post 'create', params: { comment: { body: 'body' }, post_id: 1 }

      expect(response).to redirect_to('/')
    end

    context 'when user is signed in' do
      let(:user) { create(:user, provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url') }

      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in(user)
      end

      it 'shows new form if comment is not valid' do
        comment = instance_double(Comment, save: false)
        post = instance_double(Post, id: 2)
        body = 'comment body'
        allow(Post).to receive(:find).with(post.id.to_s).and_return(post)
        allow(Comment).to receive(:new).with(
          user_id: user.id, post_id: post.id, body: body
        ).and_return(comment)

        post 'create', params: { comment: { body: body }, post_id: post.id }

        expect(response).to redirect_to('/posts/2')
      end

      it 'redirects to the post page if post was created successfully' do
        comment = instance_double(Comment, save: true)
        post = instance_double(Post, id: 2)
        body = 'comment body'
        allow(Post).to receive(:find).with(post.id.to_s).and_return(post)
        allow(Comment).to receive(:new).with(
          user_id: user.id, post_id: post.id, body: body
        ).and_return(comment)

        post 'create', params: { comment: { body: body }, post_id: post.id }

        expect(response).to redirect_to('/posts/2')
      end
    end
  end
end
