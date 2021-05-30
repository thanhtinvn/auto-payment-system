module Errors
    module DefaultHandler
        def render_error_response(e)
            case e.class.to_s
            when ActionController::RoutingError.to_s
                render_custom_error(e.message, 404, :not_found)
            when ActionController::BadRequest.to_s
                # Special exception (Rout constrains exception)
                write_log(e)
                return render_error_from_middleware('パラメタが違います。', 1022, :bad_request)
            when ActionDispatch::Http::Parameters::ParseError.to_s
                write_log(e)
                render_custom_error(e.message, 1023, :bad_request)
            when Errors::CustomException.to_s
                write_log(e)
                render_custom_error(e.message, e.code, e.status)
            when ActiveRecord::RecordNotFound.to_s
                write_log(e)
                render_custom_error('見つかりませんでした。', 404, :not_found)
            when ActiveRecord::RecordNotUnique.to_s
                write_log(e)
                render_custom_error('重複しました', 400, :bad_request)

            when ActionController::ParameterMissing.to_s
                write_log(e)
                render_custom_error(e.to_s, 404, :bad_request)

            else
                Rails.logger.error '[DEFAULT_ERROR]'
                write_log(e)
                render_default_error(e)
            end
        end

        def write_log(e)
            Rails.logger.error e.backtrace.join("\n\t").sub("\n\t", ": #{e}#{e.class ? " (#{e.class})" : ''}\n\t")
        end

        def render_default_error(e)
            render_custom_error(e.to_s)
        end

        def render_error_from_middleware(message = 'Unknown', code = 2001, status = :expectation_failed)
            respObj = Response::BaseResponse.new
            respObj.set_error(code, message)
            return [Rack::Utils::SYMBOL_TO_STATUS_CODE[status], { "Content-Type" => "application/json" }, [ respObj.to_json ]]
        end

        def render_custom_error(message = 'Unknown', code = 1001, status= :expectation_failed)
            respObj = Response::BaseResponse.new
            respObj.set_error(code, message)
            return render json: respObj.as_json, status: status
        end
    end
end