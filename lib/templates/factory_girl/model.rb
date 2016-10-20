FactoryGirl.define do
  factory :<%= model.full_resource_name %> do
<%- model.columns_for(:factory).each do |col| -%

<%- end -%
  end
end
