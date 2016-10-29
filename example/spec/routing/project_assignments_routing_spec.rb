require 'rails_helper'

RSpec.describe ProjectAssignmentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/project_assignments').to route_to('project_assignments#index')
    end

    it 'routes to #new' do
      expect(get: '/project_assignments/new').to route_to('project_assignments#new')
    end

    it 'routes to #show' do
      expect(get: '/project_assignments/1').to route_to('project_assignments#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/project_assignments/1/edit').to route_to('project_assignments#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/project_assignments').to route_to('project_assignments#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/project_assignments/1').to route_to('project_assignments#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/project_assignments/1').to route_to('project_assignments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/project_assignments/1').to route_to('project_assignments#destroy', id: '1')
    end
  end
end
