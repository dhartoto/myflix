require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    it 'creates a new @user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    # no need to test render new because it's a rails code
  end

  describe 'POST create' do
    context 'if validation passes' do
      
      before { post :create, user: Fabricate.attributes_for(:user) }

      it 'creates a new user' do
        expect(User.all.count).to eq(1)
      end
      it 'Flash a welcome message' do
        expect(flash[:success].blank?).to eq(false)
      end
      it 'assigns session[:user]' do
        expect(session[:username].blank?).to eq(false)
      end
      it 'redirects to video_path' do
        expect(response).to redirect_to videos_path
      end
    end

    context 'if validation fails' do
      before { post :create, user: { username: 'test_user' } }

      it 'does not create a user' do
        expect(User.count).to eq(0)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
      it 'creates a new @user object' do
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
end