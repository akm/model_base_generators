<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
require 'rails_helper'

<% output_attributes = model.columns.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
RSpec.describe '<%= ns_table_name %>/new', <%= type_metatag(:view) %> do
  <%= model.factory_girl_let_definitions %>
  <%= model.factory_girl_let_definition(action: :build) %>
  before(:each) do
    assign(:<%= model.full_resource_name %>, <%= model.full_resource_name %>)
  end

  it 'renders new <%= ns_file_name %> form' do
    render

    assert_select 'form[action=?][method=?]', <%= index_helper %>_path, 'post' do
<% model.columns_for(:form).each do |attribute| -%>
      <%= attribute.assert_select_exp %>
<% end -%>
    end
  end
end
