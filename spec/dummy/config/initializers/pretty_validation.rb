PrettyValidation.configure do |config|
  config.ignored_columns = {
    issues: [:status],
  }.map{|t,cols| cols.map{|c| "#{t}.#{c}"} }.flatten
end
