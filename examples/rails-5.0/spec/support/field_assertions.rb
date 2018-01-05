# frozen_string_literal: true
def assert_select_datetime_field(object, field, n = 5)
  (1..n).each do |i|
    assert_select "select##{object}_#{field}_#{i}i[name=?]", "#{object}[#{field}(#{i}i)]"
  end
end
