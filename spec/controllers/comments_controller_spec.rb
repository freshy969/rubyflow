require 'rails_helper'

describe CommentsController do
  describe 'POST #create' do
    describe 'JSON format' do
      context 'when user is signed in' do
        let(:user) { create(:user, provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url') }

        before do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          sign_in(user)
        end

        it 'returns error response if comment is not valid' do
          comment = instance_double(Comment, save: false)
          post = instance_double(Post, id: 2, slug: 'slug')
          body = 'comment body'
          allow(Post).to receive(:find_by!).with(slug: post.id.to_s).and_return(post)
          allow(Comment).to receive(:new).with(
            user_id: user.id, post_id: post.id, body: body
          ).and_return(comment)
          
          post 'create', params: { comment: { body: body }, post_id: post.id }, format: :json

          expect(response.body).to eq({success: false, message: 'Please provide the comment body!'}.to_json)
        end

        it 'returns success response if post was created successfully' do
          comment = instance_double(Comment, save: true)
          post = instance_double(Post, id: 2, slug: "slug")
          body = 'comment body'
          allow(Post).to receive(:find_by!).with(slug: post.id.to_s).and_return(post)
          allow(Comment).to receive(:new).with(
            user_id: user.id, post_id: post.id, body: body
          ).and_return(comment)

          post 'create', params: { comment: { body: body }, post_id: post.id }, format: :json

          expect(response.body).to eq({success: true, message: 'Comment added successfully!'}.to_json)
        end
      end
    end

    describe 'HTML format' do
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
          post = instance_double(Post, id: 2, slug: 'slug')
          body = 'comment body'
          allow(Post).to receive(:find_by!).with(slug: post.id.to_s).and_return(post)
          allow(Comment).to receive(:new).with(
            user_id: user.id, post_id: post.id, body: body
          ).and_return(comment)
          allow(controller).to receive(:redirect_to).with("/p/#{post.slug}",
            gflash: { error: 'Please provide the comment body!' }
          )
          
          post 'create', params: { comment: { body: body }, post_id: post.id }

          expect(controller).to have_received(:redirect_to).with("/p/#{post.slug}",
            gflash: { error: 'Please provide the comment body!' }
          ).once
        end

        it 'redirects to the post page if post was created successfully' do
          comment = instance_double(Comment, save: true)
          post = instance_double(Post, id: 2, slug: "slug")
          body = 'comment body'
          allow(Post).to receive(:find_by!).with(slug: post.id.to_s).and_return(post)
          allow(Comment).to receive(:new).with(
            user_id: user.id, post_id: post.id, body: body
          ).and_return(comment)
          allow(controller).to receive(:redirect_to).with("/p/#{post.slug}",
            gflash: { success: 'Comment added successfully!' }
          )

          post 'create', params: { comment: { body: body }, post_id: post.id }

          expect(controller).to have_received(:redirect_to).with("/p/#{post.slug}",
            gflash: { success: 'Comment added successfully!' }
          ).once
        end
      end
    end
  end
end
