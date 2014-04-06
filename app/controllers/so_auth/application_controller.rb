module SoAuth
  class ApplicationController < ActionController::Base

    protect_from_forgery

    before_filter :check_cookie
    def check_cookie
      if !cookie_valid?
        session[:user_id] = nil
      end
    end

    def cookie_valid?
      cookies[:so_auth].present? && session[:user_id].present? && cookies[:so_auth].to_s == session[:user_id].to_s
    end

    def login_required
      if !current_user
        not_authorized
      end
    end

    def not_authorized
      respond_to do |format|
        format.html{ auth_redirect }
        format.json{ head :unauthorized }
      end
    end

    def auth_redirect
      observable_redirect_to "/auth/so?origin=#{request.protocol}#{request.host_with_port}#{request.fullpath}"
    end

    def current_user
      return nil unless session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def signed_in?
      current_user.present?
    end

    helper_method :signed_in?
    helper_method :current_user




    private

    # These two methods help with testing
    def integration_test?
      Rails.env.test? && defined?(Cucumber::Rails)
    end

    def observable_redirect_to(url)
      if integration_test?
        render :text => "If this wasn't an integration test, you'd be redirected to: #{url}"
      else
        redirect_to url
      end
    end

  end
end

