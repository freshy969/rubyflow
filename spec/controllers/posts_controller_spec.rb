require 'rails_helper'

describe PostsController do
  describe 'GET #index' do
    it 'assigns posts' do
      post = instance_double(Post)
      allow(Post).to receive(:all).and_return([post])
      
      get :index
      
      expect(assigns(:posts)).to eq([post])
      expect(response).to render_template(:index)
      expect(response.code).to eq('200')
      expect(Post).to have_received(:all).once
    end
  end

  describe 'GET #show' do
    it 'assigns post' do
      post = instance_double(Post, id: 1)
      decorated_post = double('decorated_post')
      allow(Post).to receive(:find).with(post.id.to_s).and_return(post)
      allow(PostDecorator).to receive(:decorate).with(
        post
      ).and_return(decorated_post)

      get :show, params: { id: post.id }

      expect(assigns(:post)).to eq(decorated_post)
      expect(Post).to have_received(:find).with(post.id.to_s).once
      expect(response).to render_template(:show)
      expect(response.code).to eq('200')
      expect(PostDecorator).to have_received(:decorate).with(
        post
      ).once
    end
  end
end
