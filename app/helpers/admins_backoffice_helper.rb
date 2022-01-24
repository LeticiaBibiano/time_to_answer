module AdminsBackofficeHelper
  def translate_method(object = nil, method = nil)
    object.model.human_attribute_name(method)
  end
end
