# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Load custo exceptions
Dir[Rails.root.join('lib/exceptions/**/*.rb')].each { |f| require f }
