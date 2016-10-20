module ControllerMacros
  def devise_login(key, user)
    @request.env["devise.mapping"] = Devise.mappings[key]
    sign_in(user)
  end

  def devise_user_login(user)
    devise_login(:user, user)
  end

  def login_admin
    before(:each){ devise_login(:admin, FactoryGirl.create(:admin)) }
  end

  def login_user
    before(:each){ devise_login(:user, FactoryGirl.create(:user)) }
  end
end
