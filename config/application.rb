require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv::Railtie.load

module VideosSharing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.autoload_paths << Rails.root.join('lib/devise_custom')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Override ActionView::Base.field_error_proc to prevent broken html when having errors
    config.action_view.field_error_proc = Proc.new { |html_tag, _| html_tag.html_safe }
  end
end
