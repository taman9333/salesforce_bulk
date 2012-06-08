class String
  # From ActiveSupport gem: /activesupport/lib/active_support/core_ext/string/encoding.rb
  if defined?(Encoding) && "".respond_to?(:encode)
    def encoding_aware?
      true
    end
  else
    def encoding_aware?
      false
    end
  end
  
  # For converting "true" and "false" string values returned 
  # by Salesforce Bulk API in batch results to real booleans.
  def to_b
    if present?
      if lstrip.rstrip.casecmp("true") == 0
        return true
      elsif lstrip.rstrip.casecmp("false") == 0
        return false
      end
    end
    self
  end
end