# Requires supporting ruby files with Ruby core extensions, etc,
# in lib/core_ext/ and its subdirectories.
Dir[Rails.root.join("lib/core_ext/**/*.rb")].each { |f| require f }
