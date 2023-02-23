module SalesforceBulk
  # An exception raised when any non successful request is made through the Salesforce Bulk API.
  class SalesforceError < StandardError
    # The Net::HTTPResponse instance from the API call.
    attr_accessor :response
    # The status code from the server response body.
    attr_accessor :error_code
    # The exception code from Salesforce's response
    attr_accessor :exception_code

    def initialize(response)
      self.response = response
      self.error_code = response.code

      if (300..308).cover?(error_code.to_i)
        message = "Moved to #{response['location']}"
      else
        data = XmlSimple.xml_in(response.body, 'ForceArray' => false)

        if data
          # seems responses for CSV requests use a different XML return format
          # (use invalid_error.xml for reference)
          if !data['exceptionMessage'].nil?
            message = data['exceptionMessage']
            self.exception_code = data['exceptionCode']
          else
            # SOAP error response
            message = data['Body']['Fault']['faultstring']
            self.exception_code = data['Body']['Fault']['faultcode']
          end
        end
      end

      super(message)
    end
  end
end
