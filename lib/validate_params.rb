require 'validate_params/core'

module ValidateParams
  def validate_params!(*args)
    ValidateParams::Core.validate! params, args
  end
end
