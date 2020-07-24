require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VideosSharing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.autoload_paths << Rails.root.join('lib/devise_custom')

    # Prevent to generate assets and helper automatically when generating model
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.assets false
      g.helper false
      g.helper_specs false
      g.view_specs false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Override ActionView::Base.field_error_proc to prevent broken html when having errors
    config.action_view.field_error_proc = proc { |html_tag, _| html_tag.html_safe }
  end
end
