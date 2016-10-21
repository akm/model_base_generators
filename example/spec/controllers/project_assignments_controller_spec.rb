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

RSpec.describe ProjectAssignmentsController, type: :controller do

  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:user){ FactoryGirl.create(:user) }
  before{ devise_user_login(user) }

  let(:project_assignment){ FactoryGirl.create(:project_assignment, project: project, user: user) }

  # This should return the minimal set of attributes required to create a valid
  # ProjectAssignment. As you add validations to ProjectAssignment, be sure to
  # adjust the attributes here as well.
  let(:valid_parameters) {
    FactoryGirl.attributes_for(:project_assignment).merge(project_id: project.id, user_id: user.id)
  }

  let(:invalid_parameters) {
    valid_parameters.symbolize_keys.merge(project_id_id: '')
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProjectAssignmentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all project_assignments as @project_assignments" do
      get :index, params: {}, session: valid_session
      expect(assigns(:project_assignments)).to eq([project_assignment])
    end
  end

  describe "GET #show" do
    it "assigns the requested project_assignment as @project_assignment" do
      project_assignment # To create project_assignment
      get :show, params: {:id => project_assignment.to_param}, session: valid_session
      expect(assigns(:project_assignment)).to eq(project_assignment)
    end
  end

  describe "GET #new" do
    it "assigns a new project_assignment as @project_assignment" do
      get :new, params: {}, session: valid_session
      expect(assigns(:project_assignment)).to be_a_new(ProjectAssignment)
    end
  end

  describe "GET #edit" do
    it "assigns the requested project_assignment as @project_assignment" do
      project_assignment # To create project_assignment
      get :edit, params: {:id => project_assignment.to_param}, session: valid_session
      expect(assigns(:project_assignment)).to eq(project_assignment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ProjectAssignment" do
        expect {
          post :create, params: {:project_assignment => valid_parameters}, session: valid_session
        }.to change(ProjectAssignment, :count).by(1)
      end

      it "assigns a newly created project_assignment as @project_assignment" do
        post :create, params: {:project_assignment => valid_parameters}, session: valid_session
        expect(assigns(:project_assignment)).to be_a(ProjectAssignment)
        expect(assigns(:project_assignment)).to be_persisted
      end

      it "redirects to the created project_assignment" do
        post :create, params: {:project_assignment => valid_parameters}, session: valid_session
        expect(response).to redirect_to(ProjectAssignment.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved project_assignment as @project_assignment" do
        post :create, params: {:project_assignment => invalid_parameters}, session: valid_session
        expect(assigns(:project_assignment)).to be_a_new(ProjectAssignment)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:project_assignment => invalid_parameters}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:another_user_id){ FactoryGirl.create(:user_id, project: project, user: user) }

      let(:new_parameters) {
        valid_parameters.merge(user_id_id: another_user_id.id)
      }

      it "updates the requested project_assignment" do
        project_assignment # To create project_assignment
        put :update, params: {:id => project_assignment.to_param, :project_assignment => new_parameters}, session: valid_session
        project_assignment.reload
        expect(project_assignment.user_id_id).to eq another_user_id.id
      end

      it "assigns the requested project_assignment as @project_assignment" do
        project_assignment # To create project_assignment
        put :update, params: {:id => project_assignment.to_param, :project_assignment => new_parameters}, session: valid_session
        expect(assigns(:project_assignment)).to eq(project_assignment)
      end

      it "redirects to the project_assignment" do
        project_assignment # To create project_assignment
        put :update, params: {:id => project_assignment.to_param, :project_assignment => new_parameters}, session: valid_session
        expect(response).to redirect_to(project_assignment)
      end
    end

    context "with invalid params" do
      it "assigns the project_assignment as @project_assignment" do
        project_assignment # To create project_assignment
        put :update, params: {:id => project_assignment.to_param, :project_assignment => invalid_parameters}, session: valid_session
        expect(assigns(:project_assignment)).to eq(project_assignment)
      end

      it "re-renders the 'edit' template" do
        project_assignment # To create project_assignment
        put :update, params: {:id => project_assignment.to_param, :project_assignment => invalid_parameters}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested project_assignment" do
      project_assignment # To create project_assignment
      expect {
        delete :destroy, params: {:id => project_assignment.to_param}, session: valid_session
      }.to change(ProjectAssignment, :count).by(-1)
    end

    it "redirects to the project_assignments list" do
      project_assignment # To create project_assignment
      delete :destroy, params: {:id => project_assignment.to_param}, session: valid_session
      expect(response).to redirect_to(project_assignments_url)
    end
  end

end
