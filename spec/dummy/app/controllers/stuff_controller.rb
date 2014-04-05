class StuffController < SoAuth::ApplicationController

  before_filter :login_required, :only => :private

  def public
  end

  def private
  end
end
