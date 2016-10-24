require 'rails_helper'

RSpec.describe "<%= ns_table_name %>/show", <%= type_metatag(:view) %> do
  <%= model.factory_girl_let_definitions %>
  before(:each) do
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, <%= model.factory_girl_create %>)
  end

  it "renders attributes in <p>" do
    render
<% model.columns_for(:spec_show).each do |attribute| -%>
    expect(rendered).to match(<%= attribute.sample_value_regexp_exp %>)
<% end -%>
  end
end
