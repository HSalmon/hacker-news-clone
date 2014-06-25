require 'spec_helper'

describe CommentsController do

  describe 'GET index' do

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET user_comments' do

    let(:user) { double :user, id: 1 }
    let(:comment) { double :comment, user_id: user.id }

    it 'renders the index template' do
      Comment.stub(:where).and_return(comment)
      get :user_comments, id: user.id
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do

    let(:post) { double :post, post_id: 1 }

    it 'renders the new template' do
      Post.stub(:find).and_return(post)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do

    let(:post) { double :post, post_id: 1 }

    context 'with successful save' do

      # it ''
      #   Post.stub(:find).and_return(post)
      # end
    end

    context 'with unsuccessful save' do
    end
  end
end
