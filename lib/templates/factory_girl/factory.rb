FactoryGirl.define do
  factory :<%= model.full_resource_name %> do
<%- model.columns_for(:factory).each do |col| -%>
  <%- if col.reference -%>
    association :<%= col.reference.name %>, factory: :<%= col.ref_model.full_resource_name %>
  <%- else -%>
    <%= col.name %> <%= col.sample_value(context: :factory).inspect %>
  <%- end -%>
<%- end -%>
  end
end
