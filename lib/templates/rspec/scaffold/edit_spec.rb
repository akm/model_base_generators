<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
require 'rails_helper'

RSpec.describe '<%= ns_table_name %>/edit', <%= type_metatag(:view) %> do
  <%= model.factory_bot_let_definitions %>
  <%= model.factory_bot_let_definition %>
  before(:each) do
    assign(:<%= model.full_resource_name %>, <%= model.full_resource_name %>)
  end

  it 'renders the edit <%= model.full_resource_name %> form' do
    render

    assert_select 'form[action=?][method=?]', <%= model.full_resource_name %>_path(<%= model.full_resource_name %>), 'post' do
<% model.columns_for(:form).each do |attribute| -%>
      <%= attribute.assert_select_exp %>
<% end -%>
    end
  end
end
