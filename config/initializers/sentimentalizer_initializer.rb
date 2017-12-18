require 'sentimentalizer'

Mychatapp::Application.configure do
  config.after_initialize do
    Sentimentalizer.setup
  end
end
