class RadioEnumInput < Formtastic::Inputs::RadioInput
  def translate_collection(collection)
    collection.map do |c| 
      key=c.is_a?(Array) ? c[1] : c
      [I18n.t(key, :scope => "enum.#{@object.class.to_s.underscore}.#{method}"),key]
    end
  end

  def value_in_collection(value, collection)
    collection.map(&:first).include? value
  end

  def inject_other_element(collection)
    other_value = ''
    if (value=object.send(method)) && !value_in_collection(value, collection)
      @selected = 'other'
      other_value = value
    end

    # See application.js which replaces the span with an actual input
    # TODO make something more sensible
    collection << ["<span>#{CGI.escapeHTML(other_value)}</span>".html_safe, 'other']
  end

  def collection
    collection = options[:collection] || object.enums(method.to_sym)

    if options[:translate]
      collection = translate_collection(collection)
    else
      collection = collection.map{|c| [c, c]}
    end

    if options[:include_other]
      inject_other_element(collection)
    end
    collection
  end

  def selected
    if (value = @object.__send__(@method.to_sym))
      super || value.to_s
    else
      super
    end
  end

  def include_blank?
    if (value != @object.__send__(@method.to_sym))
      super
    else
      true
    end
  end
end
