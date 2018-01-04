# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AttachedFilesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/attached_files').to route_to('attached_files#index')
    end

    it 'routes to #new' do
      expect(get: '/attached_files/new').to route_to('attached_files#new')
    end

    it 'routes to #show' do
      expect(get: '/attached_files/1').to route_to('attached_files#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/attached_files/1/edit').to route_to('attached_files#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/attached_files').to route_to('attached_files#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/attached_files/1').to route_to('attached_files#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/attached_files/1').to route_to('attached_files#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/attached_files/1').to route_to('attached_files#destroy', id: '1')
    end
  end
end
