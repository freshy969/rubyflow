require 'rails_helper'

describe PostsController do
  describe 'GET #rss' do
    it 'assigns posts for RSS channel' do
      post = instance_double(Post)
      allow(Posts::RSSQuery).to receive(:call).and_return([post])

      get :rss

      expect(response.code).to eq('200')
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe 'POST #create' do
    it 'redirects to the root page if user is not signed in' do
      post :create, params: { post: { title: 'title' } }

      expect(response).to redirect_to('/')
    end

    context 'when user is signed in' do
      let(:user) { create(:user, provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url') }

      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in(user)
      end

      it 'shows new form if post is not valid' do
        post = instance_double(Post, save: false)
        title = 'Post title'
        content = 'Post content'
        allow(Post).to receive(:new).with(
          user_id: user.id, title: title, content: content
        ).and_return(post)

        post 'create', params: { post: { title: title, content: content } }

        expect(response).to render_template(:new)
        expect(assigns(:post)).to eq(post)
      end

      it 'redirects to the post page if post was created successfully' do
        post = instance_double(Post, save: true, id: 1)
        title = 'Post title'
        content = 'Post content'
        allow(Post).to receive(:new).with(
          user_id: user.id, title: title, content: content
        ).and_return(post)
        allow(controller).to receive(:redirect_to).with('/posts/1', gflash: { success: "Post added successfully!" })

        post 'create', params: { post: { title: title, content: content } }

        expect(controller).to have_received(:redirect_to).with('/posts/1', gflash: { success: "Post added successfully!" }).once
      end
    end
  end

  describe 'PUT #update' do
    it 'redirects to the root page if user is not signed in' do
      put :update, params: { id: '1', post: {} }

      expect(response).to redirect_to('/')
    end

    context 'when user is signed in' do
      let(:user) { create(:user, provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url') }

      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in(user)
      end

      it 'shows edit form if post is not valid' do
        post = instance_double(Post, id: 1, update_attributes: double)
        allow(Users::FindPostQuery).to receive(:call).with(
          post_id: '1', user: user
        ).and_return(post)
        title = 'Post title'
        content = 'Post content'
        allow(post).to receive(:update_attributes).with(
          title: title, content: content
        ).and_return(false)

        put :update, params: { id: '1', post: { title: title, content: content } }

        expect(response).to render_template(:edit)
        expect(assigns(:post)).to eq(post)
        expect(Users::FindPostQuery).to have_received(:call).with(
          post_id: '1', user: user
        ).once
      end

      it 'redirects to the post page if post was updated successfully' do
        post = instance_double(Post, id: 1, update_attributes: double)
        allow(Users::FindPostQuery).to receive(:call).with(
          post_id: '1', user: user
        ).and_return(post)
        title = 'Post title'
        content = 'Post content'
        allow(post).to receive(:update_attributes).with(
          title: title, content: content
        ).and_return(true)
        allow(controller).to receive(:redirect_to).with('/posts/1', gflash: { success: "Post updated successfully!" })

        put :update, params: { id: '1', post: { title: title, content: content } }

        expect(controller).to have_received(:redirect_to).with('/posts/1', gflash: { success: "Post updated successfully!" }).once
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to the root page if user is not signed in' do
      delete :destroy, params: { id: '1' }

      expect(response).to redirect_to('/')
    end

    it 'deletes the post if user is signed in' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user, 
        provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url'
      )
      sign_in(user)
      post = instance_double(Post, id: 1, destroy: double)
      allow(Users::FindPostQuery).to receive(:call).with(
        post_id: '1', user: user
      ).and_return(post)
      allow(post).to receive(:destroy)
      allow(controller).to receive(:redirect_to).with(:root, gflash: { success: "Post destroyed successfully!" })

      delete :destroy, params: { id: '1' }

      expect(post).to have_received(:destroy).once
      expect(controller).to have_received(:redirect_to).with(:root, gflash: { success: "Post destroyed successfully!" }).once
    end
  end

  describe 'GET #edit' do
    it 'redirects to the root page if user is not signed in' do
      get :edit, params: { id: '1' }

      expect(response).to redirect_to('/')
    end

    it 'shows edit form' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user, 
        provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url'
      )
      post = instance_double(Post, id: 1)
      allow(Users::FindPostQuery).to receive(:call).with(
        post_id: '1', user: user
      ).and_return(post)
      sign_in(user)

      get :edit, params: { id: post.id }

      expect(assigns(:post)).to eq(post)
      expect(response).to render_template(:edit)
      expect(response.code).to eq('200')
      expect(Users::FindPostQuery).to have_received(:call).with(
        post_id: '1', user: user
      ).once
    end
  end

  describe 'GET #new' do
    it 'redirects to the root page if user is not signed in' do
      get :new

      expect(response).to redirect_to('/')
    end

    it 'shows post creation form if user is signed in' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user, 
        provider: 'github', uid: '123', name: 'John Doe', image_url: 'url', profile_url: 'url'
      )
      post = instance_double(Post)
      allow(Post).to receive(:new).and_return(post)
      sign_in(user)

      get :new

      expect(assigns(:post)).to eq(post)
      expect(response).to render_template(:new)
      expect(response.code).to eq('200')
    end
  end

  describe 'GET #index' do
    it 'assigns posts' do
      post = instance_double(Post)
      another_post = instance_double(Post)
      decorated_post = double('decorated_post', created_at: '5 MAY 2018')
      another_decorated_post = double('decorated_post', created_at: '6 MAY 2018')
      allow(Posts::ListQuery).to receive(:call).and_return([post, another_post])
      allow(PostDecorator).to receive(:decorate_collection).with(
        [post, another_post]
      ).and_return([decorated_post, another_decorated_post])

      get :index
      
      grouped_posts = {
        '5 MAY 2018' => [decorated_post],
        '6 MAY 2018' => [another_decorated_post]
      }
      expect(assigns(:posts)).to eq(grouped_posts)
      expect(response).to render_template(:index)
      expect(response.code).to eq('200')
      expect(Posts::ListQuery).to have_received(:call).once
      expect(PostDecorator).to have_received(:decorate_collection).with(
        [post, another_post]
      ).once
    end
  end

  describe 'GET #show' do
    it 'assigns post' do
      post = instance_double(Post, id: 1)
      comment = instance_double(Comment)
      user = instance_double(User)
      allow(controller).to receive(:current_user).and_return(user)
      decorated_post = double('decorated_post')
      allow(Posts::FindQuery).to receive(:call).with(post.id.to_s).and_return(post)
      allow(PostDecorator).to receive(:decorate).with(
        post, context: { current_user: user }
      ).and_return(decorated_post)
      allow(Comment).to receive(:new).and_return(comment)

      get :show, params: { id: post.id }

      expect(assigns(:post)).to eq(decorated_post)
      expect(assigns(:comment)).to eq(comment)
      expect(Posts::FindQuery).to have_received(:call).with(post.id.to_s).once
      expect(response).to render_template(:show)
      expect(response.code).to eq('200')
      expect(PostDecorator).to have_received(:decorate).with(
        post, context: { current_user: user }
      ).once
    end
  end
end
