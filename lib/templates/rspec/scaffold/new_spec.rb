require 'rails_helper'

<% output_attributes = model.columns.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
RSpec.describe "<%= ns_table_name %>/new", <%= type_metatag(:view) %> do
  <%= model.factory_girl_let_definitions %>
  before(:each) do
    assign(:<%= ns_file_name %>, <%= model.factory_girl_build %>)
  end

  it "renders new <%= ns_file_name %> form" do
    render

    assert_select "form[action=?][method=?]", <%= index_helper %>_path, "post" do
<% model.columns_for(:form).each do |attribute| -%>
      <%- name = attribute.respond_to?(:column_name) ? attribute.column_name : attribute.name -%>
      assert_select "<%= attribute.input_type -%>#<%= ns_file_name %>_<%= name %>[name=?]", "<%= ns_file_name %>[<%= name %>]"
<% end -%>
    end
  end
end
