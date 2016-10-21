require 'rails_helper'

<% output_attributes = model.columns.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
RSpec.describe "<%= ns_table_name %>/index", <%= type_metatag(:view) %> do
  <%= model.factory_girl_let_definitions %>
  before(:each) do
    assign(:<%= table_name %>, [
<% [1,2].each_with_index do |id, model_index| -%>
  <%- if tc = model.title_column -%>
      <%= model.factory_girl_create(tc.name.to_sym => tc.sample_value(model_index + 1)) %>,
  <%- else -%>
      <%= model.factory_girl_create %>,
  <%- end -%>
<% end -%>
    ])
  end

  it "renders a list of <%= ns_table_name %>" do
    render
<% model.columns_for(:spec_index).each do |attribute| -%>
  <%- if attribute.ref_model || attribute.enumerized? -%>
    assert_select "tr>td", :text => <%= attribute.sample_string %>, :count => 2
  <%- else -%>
    assert_select "tr>td", :text => <%= attribute.sample_string(1) %>, :count => 1
    assert_select "tr>td", :text => <%= attribute.sample_string(2) %>, :count => 1
  <%- end -%>
<% end -%>
  end
end
