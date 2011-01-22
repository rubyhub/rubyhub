module Rubyhub
  class Application
    config.generators do |generator|
      generator.test_framework :rspec
      generator.template_engine :haml
    end
  end
end
