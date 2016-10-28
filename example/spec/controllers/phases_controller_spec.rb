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

RSpec.describe PhasesController, type: :controller do

  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:user){ FactoryGirl.create(:user) }
  before{ devise_user_login(user) }

  let(:phase){ FactoryGirl.create(:phase, project: project) }

  # This should return the minimal set of attributes required to create a valid
  # Phase. As you add validations to Phase, be sure to
  # adjust the attributes here as well.
  let(:valid_parameters) {
    FactoryGirl.attributes_for(:phase).merge(project_id: project.id)
  }

  let(:invalid_parameters) {
    valid_parameters.symbolize_keys.merge(name: '')
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PhasesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all phases as @phases" do
      get :index, params: {}, session: valid_session
      expect(assigns(:phases)).to eq([phase])
    end
  end

  describe "GET #show" do
    it "assigns the requested phase as @phase" do
      phase # To create phase
      get :show, params: {:id => phase.to_param}, session: valid_session
      expect(assigns(:phase)).to eq(phase)
    end
  end

  describe "GET #new" do
    it "assigns a new phase as @phase" do
      get :new, params: {}, session: valid_session
      expect(assigns(:phase)).to be_a_new(Phase)
    end
  end

  describe "GET #edit" do
    it "assigns the requested phase as @phase" do
      phase # To create phase
      get :edit, params: {:id => phase.to_param}, session: valid_session
      expect(assigns(:phase)).to eq(phase)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Phase" do
        expect {
          post :create, params: {:phase => valid_parameters}, session: valid_session
        }.to change(Phase, :count).by(1)
      end

      it "assigns a newly created phase as @phase" do
        post :create, params: {:phase => valid_parameters}, session: valid_session
        expect(assigns(:phase)).to be_a(Phase)
        expect(assigns(:phase)).to be_persisted
      end

      it "redirects to the created phase" do
        post :create, params: {:phase => valid_parameters}, session: valid_session
        expect(response).to redirect_to(Phase.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved phase as @phase" do
        post :create, params: {:phase => invalid_parameters}, session: valid_session
        expect(assigns(:phase)).to be_a_new(Phase)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:phase => invalid_parameters}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_name){ valid_parameters[:name].succ }
      let(:new_started_at){ valid_parameters[:started_at].succ }
      let(:new_finished_at){ valid_parameters[:finished_at].succ }

      let(:new_parameters) {
        valid_parameters.merge(name: new_name, started_at: new_started_at, finished_at: new_finished_at)
      }

      it "updates the requested phase" do
        phase # To create phase
        put :update, params: {:id => phase.to_param, :phase => new_parameters}, session: valid_session
        phase.reload
        expect(phase.name).to eq new_name
        expect(phase.started_at).to eq new_started_at
        expect(phase.finished_at).to eq new_finished_at
      end

      it "assigns the requested phase as @phase" do
        phase # To create phase
        put :update, params: {:id => phase.to_param, :phase => new_parameters}, session: valid_session
        expect(assigns(:phase)).to eq(phase)
      end

      it "redirects to the phase" do
        phase # To create phase
        put :update, params: {:id => phase.to_param, :phase => new_parameters}, session: valid_session
        expect(response).to redirect_to(phase)
      end
    end

    context "with invalid params" do
      it "assigns the phase as @phase" do
        phase # To create phase
        put :update, params: {:id => phase.to_param, :phase => invalid_parameters}, session: valid_session
        expect(assigns(:phase)).to eq(phase)
      end

      it "re-renders the 'edit' template" do
        phase # To create phase
        put :update, params: {:id => phase.to_param, :phase => invalid_parameters}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested phase" do
      phase # To create phase
      expect {
        delete :destroy, params: {:id => phase.to_param}, session: valid_session
      }.to change(Phase, :count).by(-1)
    end

    it "redirects to the phases list" do
      phase # To create phase
      delete :destroy, params: {:id => phase.to_param}, session: valid_session
      expect(response).to redirect_to(phases_url)
    end
  end

end
