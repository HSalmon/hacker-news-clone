require 'spec_helper'

describe PostsController do

  let(:user) { double :user, id: 20 }

  describe 'GET index' do

    let(:post) { double :post }

    it 'finds all of the posts sorted by popularity' do
      Post.should_receive(:by_most_popular)
      get :index
    end

    it 'assigns the posts variable' do
      Post.stub(:by_most_popular).and_return([post])
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do

    let(:comment) { double :comment }
    let(:post) { double :post, id: '8', comments: [comment] }

    before do
      Post.stub(:find_by_id).and_return(post)
    end

    it 'finds a post by id' do
      Post.should_receive(:find_by_id).with(post.id)
      get :show, id: post.id
    end

    it 'assigns the comments variable' do
      post.stub(:comments).and_return([comment])
      get :show, id: post.id
      expect(assigns(:comments)).to eq([comment])
    end

    it 'renders the show template' do
      get :show, id: post.id
      expect(response).to render_template(:show)
    end
  end


  describe 'GET user_posts' do


    it 'renders the index template' do
      post = double('post', user_id: user.id)
      Post.stub(:where).and_return(post)
      get :user_posts, id: user.id
      expect(response).to render_template(:index)
    end
  end


  describe 'GET new' do

    context 'with current user' do

      it 'renders the new template' do
        controller.stub(:current_user).and_return(user)
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'without current user' do

      before do
        get :new
      end

      it 'provides the correct flash message' do
        flash[:notice].should =~ /Gotta sign in to submit!/
      end

      it 'redirects to sign up page' do
        expect(response).to redirect_to(sign_up_path)
      end
    end
  end


  describe 'POST create' do

    before do
      controller.stub(:current_user).and_return(user)
    end

    context 'with successful save' do

      let(:valid_post) { double :post, save: true }

      before do
        Post.stub(:new).and_return(valid_post)
        valid_post.stub(:user_id=).with(user.id)
        post :create
      end

      it 'provides the correct flash message' do
        flash[:notice].should =~ /Successful post creation!/
      end

      it 'redirects to index' do
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with unsuccessful save' do

      let(:invalid_post) { double :post, save: false}

      it 're-renders new template' do
        Post.stub(:new).and_return(invalid_post)
        invalid_post.stub(:user_id=).with(user.id)
        post :create
        expect(response).to render_template(:new)
      end
    end
  end
end
