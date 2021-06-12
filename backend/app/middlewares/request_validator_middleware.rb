module RequestValidatorMiddleware
    EMP_NUM_REGEX = /^[a-zA-Z][a-zA-Z0-9]{5}$/
    SCRIPT_REGEX = /<[\w\W]+>.*<\/[\w\W]+>/
    URL_REGEX = /^(http|https):\/\/([a-zA-Z0-9.-]+(:[a-zA-Z0-9.&%$-]+)*@)*((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3}|([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.([a-zA-Z]{2,}))(:[0-9]+)*(\/($|[a-zA-Z0-9.,?'\\+&%$#=~_-]+))*$/ix
    module Signup

        def validate_parameter
            params.require([:url, :automation_filename, :username_selector, :password_selector, :login_button_selector])
            raise Errors::CustomException.new('Invalid URL', 400, :bad_request) if !(params[:url] =~ URL_REGEX) || params[:url].length > URL_MAX_LENGTH
            [:username_selector, :password_selector, :login_button_selector].each do |param_name|
                escapsed_text = params[param_name].strip.gsub(SCRIPT_REGEX, '')
                raise Errors::CustomException.new("Invalid #{param_name}", 400, :bad_request) if escapsed_text.blank? || escapsed_text.length > SELECTOR_MAX_LENGTH
                params[param_name] = escapsed_text
            end

            escaped_automation_length = params[:automation_filename].strip.gsub(SCRIPT_REGEX, '')
            raise Errors::CustomException.new("Invalid automation_filename", 400, :bad_request) if escaped_automation_length.blank? || escaped_automation_length.length > AUTOMATION_FILENAME_MAX_LENGTH
            params[:automation_filename] = escaped_automation_length
        end
    end