require File.expand_path('../boot', __FILE__)
require 'rails/all'

Bundler.require(*Rails.groups)

module Ashorten
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.generators.test_framework :rspec
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'env_vars.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exist?(env_file)
    end
  end
end
