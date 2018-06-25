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
      allow(Post).to receive(:find).with(post.id.to_s).and_return(post)

      get :show, params: { id: post.id }

      expect(assigns(:post)).to eq(post)
      expect(Post).to have_received(:find).with(post.id.to_s).once
      expect(response).to render_template(:show)
      expect(response.code).to eq('200')
    end
  end
end
