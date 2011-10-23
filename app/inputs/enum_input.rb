class EnumInput < Formtastic::Inputs::SelectInput
  def collection
    enum = @object.enums(method.to_sym)
    enum ? enum.select_options : []
  end

  def selected
    if (value = @object.__send__(@method.to_sym))
      super.selected || value.to_s
    else
      super.selected
    end
  end

  def include_blank?
    if (value != @object.__send__(@method.to_sym))
      super.include_blank?
    else
      true
    end
  end
end
