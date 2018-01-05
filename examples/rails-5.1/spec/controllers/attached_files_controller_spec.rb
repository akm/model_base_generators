# frozen_string_literal: true
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

RSpec.describe AttachedFilesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:issue) { FactoryBot.create(:issue, project: project, creator: user) }
  let(:issue_comment) { FactoryBot.create(:issue_comment, issue: issue, user: user) }
  let(:attached_file) { FactoryBot.create(:attached_file, issue_comment: issue_comment) }
  before { devise_user_login(user) }

  # This should return the minimal set of attributes required to create a valid
  # AttachedFile. As you add validations to AttachedFile, be sure to
  # adjust the attributes here as well.
  let(:valid_parameters) do
    FactoryBot.attributes_for(:attached_file).merge(issue_comment_id: issue_comment.id)
  end

  let(:invalid_parameters) do
    valid_parameters.symbolize_keys.merge(url: '')
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AttachedFilesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all attached_files as @attached_files' do
      get :index, session: valid_session,
                  params: {}
      expect(assigns(:attached_files)).to eq([attached_file])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested attached_file as @attached_file' do
      attached_file # To create attached_file
      get :show, session: valid_session,
                 params: { id: attached_file.to_param }
      expect(assigns(:attached_file)).to eq(attached_file)
    end
  end

  describe 'GET #new' do
    it 'assigns a new attached_file as @attached_file' do
      get :new, session: valid_session,
                params: {}
      expect(assigns(:attached_file)).to be_a_new(AttachedFile)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested attached_file as @attached_file' do
      attached_file # To create attached_file
      get :edit, session: valid_session,
                 params: { id: attached_file.to_param }
      expect(assigns(:attached_file)).to eq(attached_file)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new AttachedFile' do
        expect {
          post :create, session: valid_session,
                        params: { attached_file: valid_parameters }
        }.to change(AttachedFile, :count).by(1)
      end

      it 'assigns a newly created attached_file as @attached_file' do
        post :create, session: valid_session,
                      params: { attached_file: valid_parameters }
        expect(assigns(:attached_file)).to be_a(AttachedFile)
        expect(assigns(:attached_file)).to be_persisted
      end

      it 'redirects to the created attached_file' do
        post :create, session: valid_session,
                      params: { attached_file: valid_parameters }
        expect(response).to redirect_to(AttachedFile.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved attached_file as @attached_file' do
        post :create, session: valid_session,
                      params: { attached_file: invalid_parameters }
        expect(assigns(:attached_file)).to be_a_new(AttachedFile)
      end

      it "re-renders the 'new' template" do
        post :create, session: valid_session,
                      params: { attached_file: invalid_parameters }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_url) { valid_parameters[:url].succ }
      let(:new_parameters) do
        valid_parameters.merge(url: new_url)
      end

      it 'updates the requested attached_file' do
        attached_file # To create attached_file
        put :update, session: valid_session,
                     params: { id: attached_file.to_param, attached_file: new_parameters }
        attached_file.reload
        expect(attached_file.url).to eq new_url
      end

      it 'assigns the requested attached_file as @attached_file' do
        attached_file # To create attached_file
        put :update, session: valid_session,
                     params: { id: attached_file.to_param, attached_file: new_parameters }
        expect(assigns(:attached_file)).to eq(attached_file)
      end

      it 'redirects to the attached_file' do
        attached_file # To create attached_file
        put :update, session: valid_session,
                     params: { id: attached_file.to_param, attached_file: new_parameters }
        expect(response).to redirect_to(attached_file)
      end
    end

    context 'with invalid params' do
      it 'assigns the attached_file as @attached_file' do
        attached_file # To create attached_file
        put :update, session: valid_session,
                     params: { id: attached_file.to_param, attached_file: invalid_parameters }
        expect(assigns(:attached_file)).to eq(attached_file)
      end

      it "re-renders the 'edit' template" do
        attached_file # To create attached_file
        put :update, session: valid_session,
                     params: { id: attached_file.to_param, attached_file: invalid_parameters }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested attached_file' do
      attached_file # To create attached_file
      expect {
        delete :destroy, session: valid_session,
                         params: { id: attached_file.to_param }
      }.to change(AttachedFile, :count).by(-1)
    end

    it 'redirects to the attached_files list' do
      attached_file # To create attached_file
      delete :destroy, session: valid_session,
                       params: { id: attached_file.to_param }
      expect(response).to redirect_to(attached_files_url)
    end
  end
end
