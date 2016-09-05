require 'rails_helper'


RSpec.describe PeopleController, type: :controller do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: 'Name', login: Faker::Internet.name, email: Faker::Internet.email, user_id: 1}
  }

  let(:invalid_attributes) {
    {name: '', login: '', email: ''}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
  let(:valid_session) {
       {} }

  describe "index action in PeopleController" do
    before(:each) { @person = Person.create! valid_attributes }

    it "go to index action" do
      get :index, params: {page: 1, search: ''}, session: valid_session
      expect(response.status).to eq(200)
    end

    it "assigns all people" do
      get :index, params: {page: 1, search: ''}, session: valid_session
      expect([Person.last]).to eq([@person])
    end
  end


  describe "GET #show" do
    before(:each) { @person = Person.create! valid_attributes }

    it "assigns the requested post as @post" do
      get :show, {id: @person.to_param}
      expect(assigns(:person)).to eq(@person)
    end
  end

  describe "GET #new" do
    it "assigns a new post as @post" do
      get :new, params: {}, session: valid_session
      expect(assigns(:person)).to be_a_new(Person)
    end
  end

  describe "GET #edit" do
    before(:each) { @person = Person.create! valid_attributes  }

    it "assigns the requested post as @post" do
      get :edit, {id: @person.to_param}
      expect(assigns(:person)).to eq(@person)
    end
  end


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Person" do
        expect {
          post :create, {person: valid_attributes}, session: valid_session
        }.to change(Person, :count).by(1)
      end

      it "assigns a newly created person as @person" do
        post :create, {person: valid_attributes}, session: valid_session
        expect(assigns(:person)).to be_a(Person)
        expect(assigns(:person)).to be_persisted
      end

      it "redirects to the created person" do
        post :create, {person: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Person.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved person as @person" do
        post :create, {person: invalid_attributes}, session: valid_session
        expect(assigns(:person)).to be_a_new(Person)
      end

      it "re-renders the 'new' template" do
        post :create, {person: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end


  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'new name', login: 'new login', email: Faker::Internet.email}
      }

      it "updates the requested person" do
        person = Person.create! valid_attributes
        put :update, {id: person.to_param, person: new_attributes}, session: valid_session
        person.reload
      end

      it "assigns the requested person as @person" do
        person = Person.create! valid_attributes
        put :update, {id: person.to_param, person: valid_attributes}, session: valid_session
        expect(assigns(:person)).to eq(person)
      end

      it "redirects to the post" do
        person = Person.create! valid_attributes
        put :update,  {id: person.to_param, person: valid_attributes}, session: valid_session
        expect(response).to redirect_to(person)
      end
    end

    context "with invalid params" do
      it "assigns the post as @post" do
        person = Person.create! valid_attributes
        put :update,  {id: person.to_param, person: invalid_attributes}, session: valid_session
        expect(assigns(:person)).to eq(person)
      end

      it "re-renders the 'edit' template" do
        person = Person.create! valid_attributes
        put :update, {id: person.to_param, person: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end



  describe "DELETE #destroy" do
    before(:each) { @person = Person.create! valid_attributes  }
    
    it "destroys the requested person" do
      expect {
        delete :destroy, {id: @person.to_param}
      }.to change(Person, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, {id: @person.to_param}
      expect(response).to redirect_to(people_url)
    end
  end
end