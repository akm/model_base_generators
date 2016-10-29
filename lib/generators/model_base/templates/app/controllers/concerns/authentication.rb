module Authentication
  def self.included(klass)
    klass.class_eval do
      before_action :authenticate_user!
      around_action :assign_current_user
    end
  end

  def assign_current_user(&block)
    User.current(current_user, &block)
  end
end
