require 'spec_helper'

describe CommentsController do

  let(:user) { double :user, id: 19 }
  let(:post_1) { double :post, id: 124 }

  before do
    controller.stub(:current_user).and_return(user)
  end

  describe 'GET index' do

    let(:comment) { double :comment }

    before do
      Comment.stub(:all).and_return([comment])
      get :index
    end

    it 'assigns comments' do
      expect(assigns(:comments)).to eq([comment])
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET user_comments' do

    it 'renders the index template' do
      comment = double("comment", user_id: user.id)
      Comment.stub(:where).and_return(comment)
      get :user_comments, id: user.id
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do

    let(:new_comment) { double :comment }

    before do
      Comment.stub(:new).and_return(new_comment)
      Post.stub(:find).and_return(post_1)
      get :new
    end

    it 'assigns post variable' do
      expect(assigns(:post)).to eq(post_1)
    end

    it 'assigns a comment variable' do
      expect(assigns(:comment)).to eq(new_comment)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do

    let(:post_id) { '12' }
    let(:id) { '13' }
    let(:post_attrs) { { post_id: post_id, id: id } }

    let(:post_1) { double :post }
    let(:comments) { [double('comment')] }
    let(:new_comment) { double :comment, save: true, post: post_1 }

    before do
      post_1.stub(:comments).and_return(comments)
      comments.stub(:build).and_return(new_comment)
      new_comment.stub(:user_id=).with(user.id)
      Post.stub(:find).and_return(post_1)
    end

    it 'finds a post by id' do
      Post.should_receive(:find).with(post_id)
      post :create, post_attrs
    end

    context 'with successful save' do

      before do
        new_comment.stub(:save).and_return(false)
      end

      it 'renders the new template' do
        post :create, post_attrs
        expect(response).to render_template(:new)
      end
    end
  end
end