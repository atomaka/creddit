require_relative 'helpers/session_helpers'

RSpec.configure do |config|
  config.include SessionHelpers, type: :feature
end
