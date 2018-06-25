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
end
