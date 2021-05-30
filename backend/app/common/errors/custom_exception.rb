module Errors
    class CustomException < StandardError
        attr_accessor :code, :status
        def initialize (message, code = 500, httpStatus = :internal_server_error, e = nil)
            Rails.logger.error e.backtrace.join("\n\t").sub("\n\t", ": #{e}#{e.class ? " (#{e.class})" : ''}\n\t") if e.present?
            super(message)
            @code = code
            @status = httpStatus
        end
    end
end