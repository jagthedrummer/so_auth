class SoAuth::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_initializer_file
    copy_file "omniauth.rb", "config/initializers/omniauth.rb"
  end

end
