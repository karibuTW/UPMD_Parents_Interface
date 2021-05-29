class ApplicationController < ActionController::Base

  protected
  def devise_parameter_sanitizer
    if resource_class == Parent
      ParentParameterSanitizer.new(Parent, :parent, params)
    else
      super
    end
  end
end
