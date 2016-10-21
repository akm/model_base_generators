FactoryGirl.define do
  factory :<%= model.full_resource_name %> do
<%- model.columns_for(:factory).each do |col| -%>
  <%- if col.ref_model -%>
    association :<%= col.name.to_s.sub(/_id\z/, '') %>, factory: :<%= col.ref_model.full_resource_name %>
  <%- else -%>
    <%= col.name.to_s.sub(/_id\z/, '') %> <%= col.sample_value(context: :factory).inspect %>
  <%- end -%>
<%- end -%>
  end
end
