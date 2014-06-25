require 'spec_helper'

describe CommentsController do

  let(:user) { double :user, id: 1 }
  let(:post_1) { double :post, id: 1 }

  describe 'GET index' do

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET user_comments' do

    let(:comment) { double :comment, user_id: user.id }

    it 'renders the index template' do
      Comment.stub(:where).and_return(comment)
      get :user_comments, id: user.id
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do

    it 'renders the new template' do
      Post.stub(:find).and_return(post)
      get :new
      expect(response).to render_template(:new)
    end
  end

  # describe 'POST create' do

  #   let(:comment) { double :comment, save: true }

  #   context 'with successful save' do

  #     it 'provides the correct flash message' do
  #       Post.stub(:find).and_return(post_1)
  #       post_1.stub(:comments, :build).and_return(comment)
  #       comment.stub(:user_id=).with(user.id)
  #       post :create, id: post_1.id
  #       flash[:notice].should =~ /Successful comment creation!/
  #     end
  #   end
  # end
end
