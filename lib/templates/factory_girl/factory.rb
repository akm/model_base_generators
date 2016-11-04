<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
FactoryGirl.define do
  factory :<%= model.full_resource_name %> do
<%- model.columns_for(:factory).each do |col| -%>
  <%- if col.reference -%>
    <%- if col.required? -%>
    association :<%= col.reference.name %>, factory: :<%= col.ref_model.full_resource_name %>
    <%- else -%>
    <%= col.reference.name %> nil
    <%- end -%>
  <%- else -%>
    <%= col.name %> <%= col.sample_value(context: :factory).inspect.gsub(/\A\"|\"\z/, "'") %>
  <%- end -%>
<%- end -%>
  end
end
