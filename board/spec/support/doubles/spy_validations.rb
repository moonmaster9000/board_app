module SpyValidations
  def validation_failed(errors)
    @spy_validation_errors = errors
  end
  attr_reader :spy_validation_errors
end
