require 'spec_helper'

describe UsersController do

  describe 'GET show' do

    let(:user) { double :user, id: 1 }

    it 'renders the show template' do
      get :show, id: user.id
      expect(response).to render_template(:show)
    end
  end


  describe 'GET new' do

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end


  describe 'POST create' do

    context 'with successful save' do

      let(:user) { double :user, id: 2, save: true}

      before do
        User.stub(:new).and_return(user)
        post :create
      end

      it 'provides the correct flash message' do
        flash[:notice].should =~ /Successful sign up!/
      end

      it 'redirects to index' do
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with unsuccessful save' do

      let(:user) { double :user, id: 3, save: false }

      it 're-renders new template' do
        User.stub(:new).and_return(user)
        post :create
        expect(response).to render_template(:new)
      end
    end
  end
end
