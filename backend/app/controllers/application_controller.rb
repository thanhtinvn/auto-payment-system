class ApplicationController < ActionController::API
    include Errors::DefaultHandler
    rescue_from Exception, :with => :render_error_response
    before_action :authenticate ##if ENV.fetch('REQUIRE_LOGIN') {true}
    before_action :set_login_user

    after_action :set_response_header

    def authenticate
        authenticate_token || render_unauthorized
    end

    def authenticate_token
        puts '=================='
        authorization_header = request.headers['Authorization']
        return false if authorization_header.blank?
        token = authorization_header.split('=').last
        @token = Token.not_expired.find_by('BINARY token = ?', token)
        @token.present?
    end

    def set_login_user
        @current_user = @token.emp_num
    end

    def set_response_header
        response.headers['Pragma'] = 'no-cache'
        response.headers['Expires'] = -1
        response.headers['Cache-Control'] = 'no-cache'
    end

    def render_unauthorized
        obj = {message: 'Tokenは無効です！'}
        render json: obj, status: :unauthorized
    end

end
