require 'rails_helper'

RSpec.describe "<%= ns_table_name %>/edit", <%= type_metatag(:view) %> do
  before(:each) do
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, FactoryGirl.create(:<%= ns_file_name %>))
  end

  it "renders the edit <%= ns_file_name %> form" do
    render

    assert_select "form[action=?][method=?]", <%= ns_file_name %>_path(@<%= ns_file_name %>), "post" do
<% model.columns_for(:form).each do |attribute| -%>
      <%- name = attribute.respond_to?(:column_name) ? attribute.column_name : attribute.name -%>
      assert_select "<%= attribute.input_type -%>#<%= ns_file_name %>_<%= name %>[name=?]", "<%= ns_file_name %>[<%= name %>]"
<% end -%>
    end
  end
end
