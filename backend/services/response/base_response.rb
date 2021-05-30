module Response
    class BaseResponse
        include ActiveModel::Model

        attr_accessor :code, :data, :hasError, :message

        def initialize
            @code = 200
            @hasError = false
        end

        def set_error(errorCode, message = nil)
            @hasError = true
            @code = errorCode
            @message = message
        end

        def set_msg(message = nil)
            @message = message
        end

        def set_data(data = nil)
            @data = data if data
        end

        def set_code(errorCode = nil)
            @code = errorCode if errorCode
        end
    end
end
