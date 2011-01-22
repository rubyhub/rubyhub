require 'formtastic'

module Formtastic #:nodoc:
  class SemanticFormBuilder #:nodoc:
    def enum_input(method, options)
      unless options[:collection]
        enum = @object.enums(method.to_sym)
        choices = enum ? enum.select_options : []
        options[:collection] = choices
      end
      if (value = @object.__send__(method.to_sym))
        options[:selected] ||= value.to_s
      else
        options[:include_blank] ||= true
      end
      select_input(method, options)
    end
  end
end
