class SoAuth::UserSessionsController < SoAuth::ApplicationController
  before_filter :login_required, :only => [ :destroy ]

  respond_to :html

  # omniauth callback method
  def create
    omniauth = env['omniauth.auth']

    user = User.find_by_id(omniauth['uid'])
    if not user
      # New user registration
      user = User.new
      user.id = omniauth['uid']
    end
    user.email = omniauth['info']['email'] if user.respond_to?(:email)
    user.save

    session[:user_id] = user.id

    flash[:notice] = "Successfully logged in"
    redirect_to request.env['omniauth.origin'] || root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]
    redirect_to root_path
  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    reset_session
    flash[:notice] = 'You have successfully signed out!'
    redirect_to "#{ENV['AUTH_PROVIDER_URL']}/users/sign_out"
  end

end

