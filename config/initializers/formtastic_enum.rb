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
    
    def radio_enum_input(method, options)
      unless options[:collection]
        enum = @object.enums(method.to_sym)
        choices = enum ? enum.select_options : []
        options[:collection] = choices
      end
      if (value = @object.__send__(method.to_sym))
        options[:selected] ||= value.to_s
      end
      if options[:translate]
        options[:collection] = options[:collection].map do |c| 
          key=c.is_a?(Array) ? c[1] : c
          [I18n.t(key, :scope => "enum.#{@object.class.to_s.underscore}.#{method}"),key]
        end
      else
        options[:collection] = options[:collection].map{|c| [c, c]}
      end
      if options[:include_other]
        if value && !options[:collection].map{|c| c[1]}.include?(value)
          options[:collection] << ["<span>#{CGI.escapeHTML(value)}</span>".html_safe , 'other']
          options[:selected] = 'other'
        else
          options[:collection] << ['<span/>'.html_safe , 'other']
        end
      end

      radio_input(method, options)
    end
  end
end
