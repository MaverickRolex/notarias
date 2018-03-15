require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @user = create(:user)
    @permission = AuthorizationBuilder.new(resource:"UsersController", action: "manage", authorizable: @user)
    @permission.save
    sign_in @user
  end

  describe "#GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_success
    end

    it "returns 'index' template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "returns a list of 6 users" do
      create_list(:user, 5)
      get :index
      expect(assigns(:users).count).to eql(6)
    end
  end

  describe "#GET show" do
    it "returns a successful response" do
      get :show, params: { id: @user.id }
      expect(response).to be_success
    end

    it "returns 'show' template" do
      get :show, params: { id: @user.id }
      expect(response).to render_template(:show)
    end

    it "returns a user" do
      get :show, params: { id: @user.id }
      expect(assigns(:user)).to be_a(User)
    end

    it "returns the requested user" do
      get :show, params: { id: @user.id }
      expect(assigns(:user)).to eql(@user)
    end
  end

  describe "#GET new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_success
    end

    it "renders 'new' template" do
      get :new
      expect(response).to render_template(:new)
    end 

    it "returns a user" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end

    it "retuns a new user record" do
      get :new
      expect(assigns(:user)).to be_new_record
    end
  end

  describe "#GET edit" do
    it "returns a successful response" do
      get :edit, params: { id: @user.id }
      expect(response).to be_success
    end

    it "returns 'edit' template" do
      get :edit, params: { id: @user.id }
      expect(response).to render_template(:edit)
    end

    it "retuns a user" do
      get :edit, params: { id: @user.id }
      expect(assigns(:user)).to eql(@user)
    end

    it "retuns the resquested user" do
      get :edit, params: { id:@user.id }
      expect(assigns(:user)).to eql(@user)
    end
  end

  describe "#POST create" do
    it "returns a successful response" do
      expect{ post :create, params: { user: attributes_for(:user) }}.to change { User.count }.from(1).to(2)
    end

     it "redirects to 'index' if the user is created" do
      post :create, params: { user: attributes_for(:user) }
      expect(response).to redirect_to(users_path)
    end

    context "failure" do
      it "returns 'new' if user record isn't saved" do
        post :create,  params: { user: attributes_for(:user, username: "") }
        expect(response).to render_template(:new)
      end

      it "returns new" do
        post :create,  params: { user: attributes_for(:user, username: "") }
        expect(response).to render_template(:new)
      end

      it "returns errors" do
        post :create,  params: { user: attributes_for(:user, username: "") }
        expect(assigns(:user).errors).not_to be_empty
      end
    end
  end

  describe "#PUT update" do
    it "returns a user" do
        put :update,  params: { user: {username: @user.username }, id: @user.id }
        expect(assigns(:user)).to be_a(User)
    end

    it "updates user attribute" do
      put :update,  params: { user: {username: @user,  }, id: @user.id }
      expect{ @user.update(username: @user)}.to change {@user.username}
    end

    it "redirects to users index if the user record is updated" do
        put :update,  params: { user: {username: "username" }, id: @user.id }
        expect(response).to redirect_to(users_path)
    end

    it "renders a 200 http status" do
        put :update,  params: { user: {username: "" }, id: @user.id }
        expect(response).to have_http_status(200)
    end

    context "failure" do
       it "renders edit if the record isn't saved" do
        put :update,  params: { user: {username: "" }, id: @user.id }
        expect(response).to render_template(:edit)
      end

      it "returns errors" do
        put :update, params: { user: {username: ""}, id: @user.id}
        expect(assigns(:user).errors).not_to be_empty
      end

      it "renders edit" do
        put :update,  params: { user: {username: "" }, id: @user.id }
        expect(response).to render_template(:edit)
      end
    end
      
    context "params[:password] and params[:password_confirmation]" do
      it "updates encrypted_password" do
        expect { put :update,  params: { user: { password: "123456", password_confirmation: "123456" },id:@user.id }}.
          to change { @user.reload.encrypted_password }
      end

      it "doesn't update encrypted_password when blank" do
        expect { put :update,  params: { user: { 
                                                 password: nil, password_confirmation: nil, username: @user, email: @user
                                               },id:@user.id
                                       } 
               }.to_not change { @user.reload.encrypted_password }
      end
    end
  end

  describe "#POST lock" do
    it "redirects to index"do
      post :lock, params: { user:{ name: @user }, id: @user.id }
      expect(response).to redirect_to(users_path)
    end

    context "when the current_user isn't = user " do
      it "retuns a locked user" do
        @user2 = create(:user)
        post :lock, params: { id: @user2.id }
        expect(@user2.reload.access_locked?).to be(true)
      end

      it "returns can't use this action :success flash message" do
        @user2 = create(:user)
        post :lock, params: { id: @user2.id }
        expect(flash[:success]).to be_present
      end

      it "retuns a user" do
        nepe = "hola estoy en la prueba"
        post :lock, params: { id: @user.id }
        expect(assigns(:user)).to be_a(User)
      end
    end

    context "when current_user = user" do
      it "returns can't use this action :notice flash message" do
        post :lock, params: { id: @user.id }
        expect(flash[:notice]).to be_present
      end
    end 
  end

  describe "#POST unlock" do
    it "redirects to index"do
      post :unlock, params: { user:{ name: @user }, id: @user.id }
      expect(response).to redirect_to(users_path)
    end

    context "when current_user != user" do
      it "retuns a user" do
        post :unlock, params: { id: @user.id }
        expect(assigns(:user)).to be_a(User)
      end

      it "returns can't use this action :success flash message" do
        @user2 = create(:user)
        post :unlock, params: { id: @user2.id }
        expect(flash[:success]).to be_present
      end
    end

    context "when currnet_user = user" do
      it "returns can't use this action :alert flash message" do
        post :unlock, params: { id: @user.id }
        expect(flash[:alert]).to be_present
      end
    end
  end
end