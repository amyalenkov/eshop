class Users::RegistrationsController < Devise::RegistrationsController


  def after_inactive_sign_up_path_for(resourse)
    email = params[:user][:email]
    name = params[:user][:name]
    '/static_pages/confirm_registration'+'?email='+email+'&name='+name
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :name, :phone)
  end
end
