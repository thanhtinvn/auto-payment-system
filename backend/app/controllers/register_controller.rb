class RegisterController < ActionController::API
    include Errors::DefaultHandler
    rescue_from Exception, :with => :render_error_response

    def signup
        

    end


end