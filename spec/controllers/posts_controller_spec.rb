require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe PostsController, type: :controller do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
      {title: 'tytul', content: 'tresc', id:2, user_id: @user.id}
  }

  let(:invalid_attributes) {
    {title: '', content: '', id: 2, user_id: @user.id}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
  let(:valid_session) {
       {} }

  let(:user) { FactoryGirl.create(:user) }
  let(:current_user) {user}

  describe "index action in PostsController" do
    before(:each) { @post = Post.create! valid_attributes }

    it "go to index action" do
      get :index, params: {page: 1, search: ''}, session: valid_session
      expect(response.status).to eq(200)
    end


    it "assigns all posts" do
      get :index, params: {page: 1, search: ''}, session: valid_session
      expect([Post.last]).to eq([@post])
    end
  end

  describe "GET #show" do
    before(:each) { @post = Post.create! valid_attributes  }

    it "assigns the requested post as @post" do
      get :show, {id: @post.id.to_param}
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe "GET #new" do
    it "assigns a new post as @post" do
      get :new, params: {}, session: valid_session
      expect(assigns(:post)).to be_a_new(Post)
    end
  end


  describe "GET #edit" do
    before(:each) { @post = Post.create! valid_attributes  }

    it "assigns the requested post as @post" do
      get :edit, {id: @post.to_param}
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, {post: valid_attributes}, session: valid_session
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, {post: valid_attributes}, session: valid_session
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it "redirects to the created post" do
        post :create, {post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Post.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        post :create, {post: invalid_attributes}, session: valid_session
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        post :create, {post: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: 'new title', content: 'new content' }
      }

      it "updates the requested post" do
        post = Post.create! valid_attributes
        put :update, {id: post.to_param, post: new_attributes}, session: valid_session
        post.reload
      end

      it "assigns the requested post as @post" do
        post = Post.create! valid_attributes
        put :update, {id: post.to_param, post: valid_attributes}, session: valid_session
        expect(assigns(:post)).to eq(post)
      end

      it "redirects to the post" do
        post = Post.create! valid_attributes
        put :update,  {id: post.to_param, post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(post)
      end
    end

    context "with invalid params" do
      it "assigns the post as @post" do
        post = Post.create! valid_attributes
        put :update,  {id: post.to_param, post: invalid_attributes}, session: valid_session
        expect(assigns(:post)).to eq(post)
      end

      it "re-renders the 'edit' template" do
        post = Post.create! valid_attributes
        put :update, {id: post.to_param, post: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { @post = Post.create! valid_attributes  }
    
    it "destroys the requested post" do
      expect {
        delete :destroy, {id: @post.to_param}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, {id: @post.to_param}
      expect(response).to redirect_to(posts_url)
    end
  end

end
